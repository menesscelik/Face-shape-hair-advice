function recommendation = suggestHairStyle(faceShape)
    switch faceShape
        case 'Heart'
            recommendation = "Yanlara hacim kazandıran katlı kesimleri deneyin.";
        case 'Oblong'
            recommendation = "Çene hattını belirginleştiren kısa saç modellerini tercih edin.";
        case 'Oval'
            recommendation = "Oval yüzler için pek çok saç modeli uygundur.";
        case 'Round'
            recommendation = "Yanakları ince gösteren uzun ve yukarı yönlü saç modellerini seçin.";
        case 'Square'
            recommendation = "Yüz hatlarını yumuşatan dalgalı ve katlı saç modellerini deneyin.";
        otherwise
            recommendation = "Yüz şekli tespit edilemedi.";
    end
end
