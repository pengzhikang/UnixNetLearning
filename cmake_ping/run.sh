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
cmake -DCMAKE_BUILD_TYPE=Release  ..
echo "<-------------------------------End   Cmake------------------------------->"
echo "<-------------------------------Begin  Make------------------------------->"
make -j16
echo "<-------------------------------End    Make------------------------------->"
echo "<-------------------------------Begin   Run------------------------------->"
cd release
cp cmake_ping ../../bin
sudo ./cmake_ping 10.0.1.28 -c 10
sudo ./cmake_ping www.baidu.com -c 10
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:`pwd`/../../3rdparty/opencv/lib64:`pwd`/../../3rdparty/ncnn/lib:`pwd`/../../3rdparty/protobuf/lib
echo "<-------------------------------End     Run------------------------------->"

cd ../
rm -rf ./*
echo "<-------------------------------Begin Cmake------------------------------->"
cmake -DCMAKE_BUILD_TYPE=Release -DPING6=ON ..
echo "<-------------------------------End   Cmake------------------------------->"
echo "<-------------------------------Begin  Make------------------------------->"
make -j16
echo "<-------------------------------End    Make------------------------------->"
echo "<-------------------------------Begin   Run------------------------------->"
cd release
cp cmake_ping6 ../../bin
sudo ./cmake_ping6 10.0.1.28 -c 10
sudo ./cmake_ping6 www.baidu.com -c 10
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:`pwd`/../../3rdparty/opencv/lib64:`pwd`/../../3rdparty/ncnn/lib:`pwd`/../../3rdparty/protobuf/lib
echo "<-------------------------------End     Run------------------------------->"

# cd ../..
# if [ ! -d "./build" ]; then
#     mkdir build
# else
#     rm -rf build/*
# fi
# cd build
# echo "<-------------------------------Begin Cmake------------------------------->"
# cmake -DCMAKE_BUILD_TYPE=Release -DClient=OFF ..
# echo "<-------------------------------End   Cmake------------------------------->"
# echo "<-------------------------------Begin  Make------------------------------->"
# make -j16
# echo "<-------------------------------End    Make------------------------------->"
# echo "<-------------------------------Begin   Run------------------------------->"
# cd release
# cp tcpser ../../bin
# echo "<-------------------------------End     Run------------------------------->"