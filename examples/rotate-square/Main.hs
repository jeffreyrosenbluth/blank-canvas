module Main where

import Graphics.Blank

main = blankCanvas 3000 $ \ canvas -> loop canvas (0 :: Float)
 where
--    loop canvas n | n > 2 = wait canvas
    loop canvas n = do

        send canvas $ do
                (width,height) <- size
                clearRect (0,0,width,height)
                beginPath
                save
                translate (width / 2,height / 2)
                rotate (pi * n)
                beginPath
                moveTo(-100,-100)
                lineTo(-100,100)
                lineTo(100,100)
                lineTo(100,-100)
                closePath
                lineWidth 10
                strokeStyle $ rgba (100,200,128,255)
                stroke
                restore

        loop canvas (n + 0.01)
