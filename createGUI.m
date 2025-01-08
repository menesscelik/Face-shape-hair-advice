function createGUI()
    % Ana GUI Penceresi
    fig = uifigure('Name', 'Yüz Şekline Göre Saç Önerisi', 'Position', [100, 100, 600, 400]);
    
    % Fotoğraf Yükleme Butonu
    btnUpload = uibutton(fig, 'Position', [50, 300, 200, 30], 'Text', 'Fotoğraf Yükle', ...
        'ButtonPushedFcn', @(btn, event) loadImage(fig));
    
    % Öneri Alanı
    resultLabel = uilabel(fig, 'Position', [50, 150, 500, 100], ...
        'Text', '', 'HorizontalAlignment', 'center', 'FontSize', 14, 'WordWrap', 'on');
    
    % Görüntüleme Alanı
    ax = uiaxes(fig, 'Position', [300, 150, 250, 250]);
    title(ax, 'Yüklü Fotoğraf');
    setappdata(fig, 'ax', ax);
    setappdata(fig, 'resultLabel', resultLabel);
end

function loadImage(fig)
    % Fotoğraf seçme ve yükleme
    [file, path] = uigetfile({'*.jpg;*.png', 'Image Files (*.jpg, *.png)'});
    if isequal(file, 0)
        return; % Dosya seçilmediyse işlem yapılmaz
    end
    imagePath = fullfile(path, file);
    ax = getappdata(fig, 'ax');
    imshow(imagePath, 'Parent', ax);

    % Yüz şekli tespiti ve öneri
    try
        faceShape = detectFaceShape(imagePath);
        recommendation = suggestHairStyle(faceShape);
        resultLabel = getappdata(fig, 'resultLabel');
        resultLabel.Text = sprintf('Tespit Edilen Yüz Şekli: %s\n\nÖneri: %s', faceShape, recommendation);
    catch ME
        resultLabel = getappdata(fig, 'resultLabel');
        resultLabel.Text = sprintf('Hata: %s', ME.message);
    end
end
