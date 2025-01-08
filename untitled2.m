clc; clear all;

% CSV dosyasını yükle
trainCsv = readtable('FaceShape/train/_classes.csv'); % Eğitim CSV'si
validCsv = readtable('FaceShape/valid/_classes.csv'); % Doğrulama CSV'si
testCsv = readtable('FaceShape/test/_classes.csv'); % Test CSV'si

% Eğitim etiketi belirleme
labels = strings(height(trainCsv), 1);
for i = 1:height(trainCsv)
    if trainCsv.Heart(i) == 1
        labels(i) = 'Heart';
    elseif trainCsv.Oblong(i) == 1
        labels(i) = 'Oblong';
    elseif trainCsv.Oval(i) == 1
        labels(i) = 'Oval';
    elseif trainCsv.Round(i) == 1
        labels(i) = 'Round';
    elseif trainCsv.square(i) == 1
        labels(i) = 'square';
    end
end
trainLabels = categorical(labels); % Etiketleri kategorik hale getir

% Doğrulama etiketi belirleme
validLabels = strings(height(validCsv), 1);
for i = 1:height(validCsv)
    if validCsv.Heart(i) == 1
        validLabels(i) = 'Heart';
    elseif validCsv.Oblong(i) == 1
        validLabels(i) = 'Oblong';
    elseif validCsv.Oval(i) == 1
        validLabels(i) = 'Oval';
    elseif validCsv.Round(i) == 1
        validLabels(i) = 'Round';
    elseif validCsv.square(i) == 1
        validLabels(i) = 'square';
    end
end
validLabels = categorical(validLabels); % Etiketleri kategorik hale getir

% Test etiketi belirleme
testLabels = strings(height(testCsv), 1);
for i = 1:height(testCsv)
    if testCsv.Heart(i) == 1
        testLabels(i) = 'Heart';
    elseif testCsv.Oblong(i) == 1
        testLabels(i) = 'Oblong';
    elseif testCsv.Oval(i) == 1
        testLabels(i) = 'Oval';
    elseif testCsv.Round(i) == 1
        testLabels(i) = 'Round';
    elseif testCsv.square(i) == 1
        testLabels(i) = 'square';
    end
end
testLabels = categorical(testLabels); % Etiketleri kategorik hale getir

% Görüntü veri deposu oluşturma
trainImages = imageDatastore(fullfile('FaceShape/train', trainCsv.filename), ...
    'ReadFcn', @(x)imresize(imread(x), [299 299])); % Eğitim görüntüleri
validImages = imageDatastore(fullfile('FaceShape/valid', validCsv.filename), ...
    'ReadFcn', @(x)imresize(imread(x), [299 299])); % Doğrulama görüntüleri
testImages = imageDatastore(fullfile('FaceShape/test', testCsv.filename), ...
    'ReadFcn', @(x)imresize(imread(x), [299 299])); % Test görüntüleri

% Etiketleri arrayDatastore formatına dönüştür
trainLabelsDs = arrayDatastore(trainLabels);
validLabelsDs = arrayDatastore(validLabels);
testLabelsDs = arrayDatastore(testLabels);

% Görüntüleri ve etiketleri birleştir
trainData = combine(trainImages, trainLabelsDs); % Eğitim veri deposu
validData = combine(validImages, validLabelsDs); % Doğrulama veri deposu
testData = combine(testImages, testLabelsDs); % Test veri deposu

% Inception-v3 modelini yükle
net = inceptionv3;

% Modelin katmanlarını alın ve son katmanları özelleştirin
lgraph = layerGraph(net);

% Sınıf sayısını belirle
numClasses = numel(categories(trainLabels)); % Sınıf sayısını alın

% Yeni fully connected ve classification katmanlarını ekle
newFc = fullyConnectedLayer(numClasses, 'Name', 'fc', ...
    'WeightLearnRateFactor', 10, 'BiasLearnRateFactor', 10);
newClassificationLayer = classificationLayer('Name', 'output');

% Mevcut son katmanları çıkar ve yenilerini ekle
lgraph = replaceLayer(lgraph, 'predictions', newFc); % Fully connected layer adı 'predictions'
lgraph = replaceLayer(lgraph, 'ClassificationLayer_predictions', newClassificationLayer); % Classification layer

% Eğitim seçeneklerini belirle
options = trainingOptions('adam', ...
    'InitialLearnRate', 1e-3, ... % Daha yüksek başlangıç öğrenme oranı
    'LearnRateSchedule', 'piecewise', ...
    'LearnRateDropPeriod', 5, ...
    'LearnRateDropFactor', 0.5, ...
    'MaxEpochs', 10, ... % Epoch sayısı
    'MiniBatchSize', 32, ... % Mini-batch boyutu
    'ValidationData', validData, ... % Doğrulama veri seti
    'ValidationFrequency', 50, ...
    'Shuffle', 'every-epoch', ...
    'Plots', 'training-progress', ...
    'Verbose', false);

% Modeli eğit
trainedNet = trainNetwork(trainData, lgraph, options);

% Eğitilen modeli kaydet
save('inceptionv3_face_shape_model.mat', 'trainedNet');
disp('Model başarıyla eğitildi ve kaydedildi!');

% *** Test Veri Seti ile Modeli Değerlendirme ***
% Test veri setindeki tahminleri alın
predictedLabels = classify(trainedNet, testImages);

% Test doğruluk oranını hesaplayın
testAccuracy = mean(predictedLabels == testLabels) * 100;
disp(['Test Doğruluk Oranı: ', num2str(testAccuracy), '%']);

% Yanlış tahmin edilen örnekleri bulun
mismatchIdx = find(predictedLabels ~= testLabels);

% Yanlış tahmin edilen örnek sayısını görüntüle
disp(['Yanlış tahmin edilen örnek sayısı: ', num2str(length(mismatchIdx))]);

% Yanlış tahminleri görselleştir
if ~isempty(mismatchIdx)
    figure;
    for i = 1:min(5, length(mismatchIdx)) % İlk 5 yanlış tahmini göster
        idx = mismatchIdx(i);
        img = readimage(testImages, idx);
        subplot(1, 5, i);
        imshow(img);
        title(['Gerçek: ', char(testLabels(idx)), ...
               ' - Tahmin: ', char(predictedLabels(idx))]);
    end
end