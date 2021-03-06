# Распознавание рукописных цифр
В данном проекте я работаю с известным датасетом mnist из tensorflow.keras.datasets.  
Обучающая выборка имеет размер 60,000, тестовая выборка имеет размер 10,000.
Цель моей работы - обучить нейронную сеть, которая сможет распознавать рукописные цифры (цифры в диапазоне от 0 до 9 включительно).  
В качестве свётрочной нейронной сети используется Sequential со слоями Conv2D. При создании модели применялись MaxPooling2D (пулинг) для уменьшения размера представлений, а также Dropout для регуляризации модели.  
Данная модель имеет в сумме 600,810 параметров.  
После обучения этой модели на 100 epochs, модель способна предсказывать верные значения с вероятностью 92.3 %.  
Также, внизу ноутбука находятся три примера предсказаний. В первом и втором примере числа были предсказаны верно, в третьем же модель предсказала число 7 вместо числа 3.

### В заключение можно сказать, что нейронная сеть смогла показать хороший результат, а неправильные предсказания происходят лишь в тех случаях, когда цифры записаны не очень разборчиво.