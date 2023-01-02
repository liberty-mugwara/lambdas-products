@echo off
IF exist .\build (echo building ...) ELSE (mkdir .\build && echo building ...)
tar -a -c -f ./build/lambda.zip ArchiveProductQuantityData.py
echo Process Complete!