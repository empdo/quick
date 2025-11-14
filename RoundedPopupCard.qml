import QtQuick

Item {
    id: root

    default property alias content: contentItem.data

    property color backgroundColor: "#1a1a1a"
    property color borderColor: "#ebffd9"
    property real outerRadius: 18     // normal round corners
    property real innerRadius: 42     // inward curve radius

    implicitWidth: 260
    implicitHeight: contentItem.implicitHeight

    Canvas {
        id: canvas
        anchors.fill: parent
        antialiasing: true
        smooth: true
        onPaint: {
            const ctx = getContext("2d");
            const w = width;
            const h = height;

            const OR = root.outerRadius;   // convex bottom-left and other corners
            const IR = root.innerRadius;   // concave *top-left* radius

            ctx.clearRect(0, 0, w, h);
            ctx.beginPath();

            ctx.moveTo(0, 0);

            ctx.quadraticCurveTo(0, IR, IR, IR);

            ctx.lineTo(w - OR, IR);
            ctx.quadraticCurveTo(w, IR, w, IR + OR);

            ctx.lineTo(w, h - IR - OR);
            ctx.quadraticCurveTo(w, h - IR, w - OR, h - IR);

            ctx.lineTo(OR, h - IR);


            ctx.quadraticCurveTo(0, h - IR, 0, h);


            ctx.fillStyle = root.backgroundColor;
            ctx.strokeStyle = root.borderColor;
            ctx.lineWidth = 1;

            ctx.fill();
            ctx.stroke();

        }
    }

    // Clip content to canvas shape
    Item {
        id: contentItem
        anchors.fill: parent
        clip: true
    }

    // Shadow (optional)
    layer.enabled: true
    layer.smooth: true
    layer.samples: 16
}
