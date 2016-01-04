import QtQuick 2.5
import "../styles.js" as Styles

Rectangle {
    property string text
    property bool isSelected: false
    property string iconStr
    property int borderWidth: 6
    property int iconSize: 20
    property bool highlightOn: false

    id: root
    height: dp(60)
    anchors {
        left: parent.left
        right: parent.right
    }
    color: "transparent"

    function setFocus(isActive){
        border.width = isActive ? (g_toolBox.isOpen ? dp(14) : dp(60)) : 0
//        borderTop.height = isActive ? dp(1) : 0
//        borderBottom.height = isActive ? dp(1) : 0
        color = isActive ? Styles.ribbonSelected : "transparent"
        isSelected = isActive
        iconLabel.anchors.centerIn = g_toolBox.isOpen ? null : root
    }

    Connections {
        target: g_toolBox
        onIsOpenChanged: {
            setFocus(isSelected)
        }
    }

    function setHighlight(isActive){
        if (highlightOn){
            if (!isSelected)
                color = isActive ? Styles.ribbonHighlight : "transparent"
        }
        iconLabel.iconColor = isActive ? Styles.iconHighlight : Styles.iconColor
        textLabel.color = isActive ? Styles.textColor : Styles.iconColor
    }

    Rectangle {
        id: border
        color: Styles.purple
        width: 0
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
        }
        Behavior on width {
            NumberAnimation {
                duration: 150
                easing.type: Easing.OutCubic
            }
        }
    }


//    Rectangle {
//        id: borderTop
//        height: 0
//        color: Styles.border
//        anchors {
//            top: parent.top
//            left: parent.left
//            right: parent.right
//        }
//    }

//    Rectangle {
//        id: borderBottom
//        height: 0
//        color: Styles.border
//        anchors {
//            left: parent.left
//            right: parent.right
//            bottom: parent.bottom
//        }
//    }

    Text {
        id: textLabel
        visible: g_toolBox.isOpen
        anchors.centerIn: parent
        text: root.text
        color: Styles.iconColor
        font.pointSize: dp(Styles.titleFont.bigger)
    }

    Icon {
        id: iconLabel
        icon: iconStr
        iconSize: dp(root.iconSize)
        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
        }
    }

}