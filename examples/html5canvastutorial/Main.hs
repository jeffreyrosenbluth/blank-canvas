module Main (main) where

import Graphics.Blank

main = blankCanvas 3000 $ \ canvas ->
  sequence_ [ -- blank the screeen
              do send canvas $ do
                      w <- width
                      h <- height
                      clearRect (0,0,w,h)
                      beginPath()

                 -- run this example
                 send canvas $ do
                      save()
                      example
                      restore()

                 -- draw the watermark in corner
                 send canvas $ message name

                 -- wait for a mouse press
                 send canvas $ readEvent MouseDown

            | (example,name) <- cycle examples
            ]

examples =
        [ (example_1_2_1,"1.2.1 Line")
        , (example_1_2_2,"1.2.2 Line Width")
        , (example_1_2_3,"1.2.3 Line Color")
        , (example_1_2_4,"1.2.4 Line Cap")
        , (example_1_3_1,"1.3.1 Arc")
        , (example_1_8_1,"1.8.1 Text Font & Size")
        , (example_1_8_2,"1.8.2 Text Color")
        , (example_1_8_3,"1.8.3 Text Stroke")
        , (example_1_8_4,"1.8.4 Text Align")
        , (example_1_8_5,"1.8.5 Text Baseline")
        ]

-- Examples taken from http://www.html5canvastutorials.com/tutorials/html5-canvas-tutorials-introduction/

{- For example, here is the JavaScript for 1.2.1
        context.moveTo(100, 150);
        context.lineTo(450, 50);
        context.stroke();
-}
example_1_2_1 = do
        moveTo(100,150)
        lineTo(450,50)
        stroke()

example_1_2_2 = do
        moveTo(100,150)
        lineTo(450,50)
        lineWidth 15
        stroke()

example_1_2_3 = do
        moveTo(100,150)
        lineTo(450,50)
        lineWidth 5
        strokeStyle "#ff0000"
        stroke()

example_1_2_4 = do
        w <- width
        h <- height

        sequence_
           [ do beginPath()
                moveTo(200, h / 2 + n)
                lineTo(w - 200, h / 2 + n)
                lineWidth 20
                strokeStyle "#0000ff"
                lineCap cap
                stroke()
           | (cap,n) <- zip ["butt","round","square"] [-50,0,50]
           ]

example_1_3_1 = do
        w <- width
        h <- height
        let centerX = w / 2;
        let centerY = h / 2;
        let radius = 75;
        let startingAngle = 1.1 * pi
        let endingAngle = 1.9 * pi
        let counterclockwise = False
        arc(centerX, centerY, radius, startingAngle, endingAngle, counterclockwise)
        lineWidth 15
        strokeStyle "black"
        stroke()

example_1_8_1 = do
        font "40pt Calibri"
        fillText("Hello World!", 150, 100)

example_1_8_2 = do
        font "40pt Calibri"
        fillStyle "#0000ff"
        fillText("Hello World!", 150, 100)

example_1_8_3 = do
        font "60pt Calibri"
        lineWidth 3
        strokeStyle "blue"
        strokeText("Hello World!", 80, 110)

example_1_8_4 = do
        w <- width
        h <- height
        let centerX = w / 2;
        let centerY = h / 2;
        font "30pt Calibri"
        textAlign "center"
        fillStyle "blue"
        fillText("Hello World!", centerX, centerY)

example_1_8_5 = do
        w <- width
        h <- height
        let centerX = w / 2;
        let centerY = h / 2;
        font "30pt Calibri"
        textAlign "center"
        textBaseline "middle"
        fillStyle "blue"
        fillText("Hello World!", centerX, centerY)


---------------------------------------------------------------------------

-- Small "watermark-like text in the bottom corner"
message :: String -> Canvas ()
message msg = do
        save()
        w <- width
        h <- height
        font "30pt Calibri"
        textAlign "left"
        fillStyle "#8090a0"
        fillText(msg, 10, h - 10)
        restore()
