function faceShape = detectFaceShape(imagePath)
    % Eğitilmiş modeli yükle
    load('inceptionv3_face_shape_model.mat', 'trainedNet');
    
    % Görüntüyü yükle ve yeniden boyutlandır
    image = imread(imagePath);
    image = imresize(image, [299 299]);
    
    % Yüz şekli tahmini
    predictedLabel = classify(trainedNet, image);
    faceShape = char(predictedLabel);
end
