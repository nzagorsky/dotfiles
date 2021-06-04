
To enable hardware-accelerated video set following flags to `Enabled`:
 
    chrome://flags/#enable-accelerated-video-decode
    chrome://flags/#enable-gpu-rasterization


In case something is still not enabled try out:

    chrome://flags/#ignore-gpu-blocklist

And for additional adventure:

    chrome://flags/#enable-vulkan


Check here: chrome://gpu/

As of late (Chromium 91+) there is a requirement to add following parameters to the launch command:

    google-chrome-stable --use-gl=desktop --enable-features=VaapiVideoDecoder
