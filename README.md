# Yüz Şekli Tespiti ve Saç Modeli Önerisi

Bu proje, görüntülerden yüz şekillerini tespit etmek ve kişiselleştirilmiş saç modeli önerileri sunmak için MATLAB tabanlı bir uygulamadır. Derin öğrenme teknikleri ve kullanıcı dostu bir grafiksel arayüz (GUI) sunar.

## Özellikler
- **Yüz Şekli Tespiti**: Eğitilmiş bir Inception-v3 modeli kullanarak yüz şekillerini (Örneğin, Kalp, Dikdörtgen, Oval, Yuvarlak, Kare) belirler.
- **Kişiselleştirilmiş Saç Modeli Önerileri**: Tespit edilen yüz şekline dayalı öneriler sunar.
- **Grafiksel Kullanıcı Arayüzü (GUI)**: Kullanıcıların bir görüntü yüklemesini ve sonuçları interaktif olarak görüntülemesini sağlar.

## Gereksinimler
Bu projeyi çalıştırmak için aşağıdaki gereksinimlere sahip olmalısınız:

1. MATLAB (R2021a veya daha yeni bir sürüm önerilir).
2. `Deep Learning Toolbox`, derin öğrenme modeli eğitimi ve kullanımı için gereklidir.
3. Gerekli proje dosyaları:
   - `createGUI.m`: Uygulama için GUI.
   - `detectFaceShape.m`: Yüz şekli tespiti için kod.
   - `suggestHairStyle.m`: Yüz şekline göre saç modeli önerileri sunar.
   - `untitled2.m`: Derin öğrenme modeli eğitimi için kullanılan betik.
   - Eğitilmiş model: `inceptionv3_face_shape_model.mat` (Bu model `untitled2.m` çalıştırılarak oluşturulabilir).

## Dizin Yapısı
```
FaceShapeProject/
├── FaceShape/
│   ├── train/
│   │   ├── _classes.csv
│   │   └── [eğitim görüntüleri]
│   ├── valid/
│   │   ├── _classes.csv
│   │   └── [doğrulama görüntüleri]
│   └── test/
│       ├── _classes.csv
│       └── [test görüntüleri]
├── createGUI.m
├── detectFaceShape.m
├── suggestHairStyle.m
├── untitled2.m
└── inceptionv3_face_shape_model.mat
```

## Kullanım

### Adım 1: Modeli Eğitme
`untitled2.m` dosyasını çalıştırarak Inception-v3 modelini, `FaceShape/train` dizininde sağlanan veri kümesiyle eğitin. Eğitilen model `inceptionv3_face_shape_model.mat` olarak kaydedilecektir.

```matlab
>> untitled2
```

### Adım 2: Uygulamayı Başlatma
`createGUI.m` dosyasını çalıştırarak GUI'yi başlatın. Bu arayüzden bir görüntü yükleyebilir, yüz şekli tespiti yapabilir ve öneriler alabilirsiniz.

```matlab
>> createGUI
```

### Adım 3: Görüntü Yükleme
1. **"Fotoğraf Yükle"** butonuna tıklayın.
2. Bir görüntü dosyası seçin (örn. `.jpg` veya `.png`).
3. Tespit edilen yüz şekli ve saç modeli önerisi uygulamada görüntülenecektir.

## Temel Dosyalar

### `createGUI.m`
- GUI'yi başlatır.
- Kullanıcıların görüntü yüklemesine olanak tanır.
- Tespit edilen yüz şeklini ve önerileri görüntüler.

### `detectFaceShape.m`
- Eğitilmiş modeli (`inceptionv3_face_shape_model.mat`) yükler.
- Yüklenen bir görüntüden yüz şeklini tespit eder.

### `suggestHairStyle.m`
- Tespit edilen yüz şekline göre saç modeli önerileri sunar.

### `untitled2.m`
- Inception-v3 modelini veri kümesiyle eğitir.
- Eğitilen modeli daha sonra kullanmak üzere kaydeder.

## Veri Kümesi
Veri kümesinin aşağıdaki şekilde organize edilmesi gerekir:

- **Eğitim Verisi**: `FaceShape/train` dizininde saklanır. Görseller ve etiketler `_classes.csv` dosyasında belirtilir.
- **Doğrulama Verisi**: `FaceShape/valid` dizininde saklanır.
- **Test Verisi**: `FaceShape/test` dizininde saklanır.

Her `_classes.csv` dosyası şu şekilde olmalıdır:
```
filename,Heart,Oblong,Oval,Round,Square
image1.jpg,1,0,0,0,0
image2.jpg,0,1,0,0,0
...
```

## Gelecek Geliştirmeler
- Daha fazla yüz şekli ve saç modeli desteği eklenebilir.
- Daha fazla veri ile yüz şekli tespit doğruluğu artırılabilir.
- Sonuçları kaydetmek için GUI işlevselliği genişletilebilir.



---
Sorularınız veya destek için bizimle iletişime geçebilirsiniz.
