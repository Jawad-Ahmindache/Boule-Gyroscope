import QtQuick 2.12
import QtQuick.Window 2.12
import QtSensors 5.15

Window {
    width: 800
    height: 800
    visible: true
    title: qsTr("Hello World")
    id:fenetre
    Rectangle {
        id:unRond
        width: parent.width/6
        height: width
        radius: width*0.5
        color: "orange"
        x:0
        y:0
    }
    Accelerometer{
        id: accel
        dataRate: 100
        active: true
        onReadingChanged: {
            var newX = calcRoll(accel.reading.x,accel.reading.y,accel.reading.z)
            var newY = calcPitch(accel.reading.x, accel.reading.y,accel.reading.z)


            if((unRond.x + newX) > 0 && (unRond.x + newX) < (fenetre.width - unRond.width) ){

                unRond.x += newX;
                if((unRond.x + newX) > (fenetre.width - unRond.width)) {
                    unRond.x = fenetre.width - unRond.width
                }

            }
            if((unRond.y + newY) > 0 && (unRond.y + newY) < (fenetre.height - unRond.height) ){
                unRond.y += newY;
                if((unRond.y + newY) > (fenetre.height - unRond.height)) {
                    unRond.y = (fenetre.height - unRond.height)
                }
            }
        }

        function calcPitch(x,y,z){
            return (Math.atan(y/ Math.sqrt(x*x + z*z)) * 57.2957795);
        }

        function calcRoll(x,y,z){
            return -(Math.atan(x/ Math.sqrt(y*y + z*z)) * 57.2957795);
        }

    }
}
