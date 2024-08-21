<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dot Game</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f0f0f0;
        }
        #gameCanvas {
            border: 2px solid #000;
            background-color: #fff;
        }
    </style>
</head>
<body>
    <canvas id="gameCanvas" width="800" height="600"></canvas>
    <script>
        const canvas = document.getElementById('gameCanvas');
        const ctx = canvas.getContext('2d');

        let score = 0;
        const dots = [];
        const numDots = 10;
        const dotRadius = 15;

        function createDot() {
            return {
                x: Math.random() * (canvas.width - dotRadius * 2) + dotRadius,
                y: Math.random() * (canvas.height - dotRadius * 2) + dotRadius,
                radius: dotRadius,
                color: '#' + Math.floor(Math.random()*16777215).toString(16)  // Random color
            };
        }

        function drawDot(dot) {
            ctx.beginPath();
            ctx.arc(dot.x, dot.y, dot.radius, 0, Math.PI * 2);
            ctx.fillStyle = dot.color;
            ctx.fill();
            ctx.closePath();
        }

        function drawDots() {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            dots.forEach(dot => drawDot(dot));
        }

        function handleClick(event) {
            const rect = canvas.getBoundingClientRect();
            const x = event.clientX - rect.left;
            const y = event.clientY - rect.top;

            dots.forEach((dot, index) => {
                const dist = Math.sqrt((x - dot.x) ** 2 + (y - dot.y) ** 2);
                if (dist < dot.radius) {
                    score++;
                    dots.splice(index, 1);
                    addDot();
                }
            });

            drawDots();
            document.title = `Score: ${score}`;
        }

        function addDot() {
            if (dots.length < numDots) {
                dots.push(createDot());
            }
        }

        function init() {
            for (let i = 0; i < numDots; i++) {
                addDot();
            }
            drawDots();
        }

        canvas.addEventListener('click', handleClick);

        init();
    </script>
</body>
</html>

