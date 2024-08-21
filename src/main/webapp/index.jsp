<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cube Links Game</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f0f0f0;
            font-family: Arial, sans-serif;
        }
        #gameContainer {
            position: relative;
            width: 800px;
            height: 600px;
            border: 2px solid #000;
            background-color: #fff;
        }
        .cube {
            position: absolute;
            width: 50px;
            height: 50px;
            background-color: #007bff;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .cube:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div id="gameContainer"></div>
    <div id="scoreBoard" style="text-align: center; margin-top: 20px;">
        <h2>Score: <span id="score">0</span></h2>
    </div>
    <script>
        const container = document.getElementById('gameContainer');
        const scoreDisplay = document.getElementById('score');
        let score = 0;
        const cubes = [];
        const numCubes = 10;
        const cubeSize = 50;
        const linkThreshold = 70; // Distance threshold for linking

        function createCube() {
            const cube = document.createElement('div');
            cube.className = 'cube';
            cube.style.top = `${Math.random() * (container.clientHeight - cubeSize)}px`;
            cube.style.left = `${Math.random() * (container.clientWidth - cubeSize)}px`;
            cube.dataset.id = cubes.length;
            cube.addEventListener('click', handleClick);
            container.appendChild(cube);
            return cube;
        }

        function handleClick(event) {
            const clickedCube = event.target;
            const id = clickedCube.dataset.id;
            const linkedCubes = cubes.filter(cube => cube !== clickedCube && isLinked(clickedCube, cube));
            
            if (linkedCubes.length > 0) {
                score++;
                scoreDisplay.textContent = score;
                clickedCube.style.backgroundColor = '#28a745'; // Change color when linked
                linkedCubes.forEach(cube => cube.style.backgroundColor = '#28a745');
            }
        }

        function isLinked(cube1, cube2) {
            const rect1 = cube1.getBoundingClientRect();
            const rect2 = cube2.getBoundingClientRect();
            const distance = Math.sqrt(
                Math.pow(rect1.left - rect2.left, 2) +
                Math.pow(rect1.top - rect2.top, 2)
            );
            return distance <= linkThreshold;
        }

        function init() {
            for (let i = 0; i < numCubes; i++) {
                cubes.push(createCube());
            }
        }

        init();
    </script>
</body>
</html>

