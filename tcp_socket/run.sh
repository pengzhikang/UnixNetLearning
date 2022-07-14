if [ ! -d "./build" ]; then
    mkdir build
else
    rm -rf build/*
fi

if [ ! -d "./bin" ]; then
    mkdir bin
else
    rm -rf bin/*
fi
cd build
echo "<-------------------------------Begin Cmake------------------------------->"
cmake -DCMAKE_BUILD_TYPE=Release -DClient=ON ..
echo "<-------------------------------End   Cmake------------------------------->"
echo "<-------------------------------Begin  Make------------------------------->"
make -j16
echo "<-------------------------------End    Make------------------------------->"
echo "<-------------------------------Begin   Run------------------------------->"
cd release
cp tcpcli ../../bin
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:`pwd`/../../3rdparty/opencv/lib64:`pwd`/../../3rdparty/ncnn/lib:`pwd`/../../3rdparty/protobuf/lib
echo "<-------------------------------End     Run------------------------------->"
cd ../..
if [ ! -d "./build" ]; then
    mkdir build
else
    rm -rf build/*
fi

cd build
echo "<-------------------------------Begin Cmake------------------------------->"
cmake -DCMAKE_BUILD_TYPE=Release -DClient=OFF ..
echo "<-------------------------------End   Cmake------------------------------->"
echo "<-------------------------------Begin  Make------------------------------->"
make -j16
echo "<-------------------------------End    Make------------------------------->"
echo "<-------------------------------Begin   Run------------------------------->"
cd release
cp tcpser ../../bin
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:`pwd`/../../3rdparty/opencv/lib64:`pwd`/../../3rdparty/ncnn/lib:`pwd`/../../3rdparty/protobuf/lib
echo "<-------------------------------End     Run------------------------------->"
# cd ../../bin
# ./tcpser || ./tcpcli 