#!/bin/bash

mkdir folder
cd folder
virtualenv v-env
source ./v-env/bin/activate

for dep in $@
do
    echo "Installing $dep"
    pip install $dep
done  

deactivate
mkdir python
cd python
cp -r ../v-env/lib64/python{X.x}/site-packages/* .
cd .. 
zip -r {zip-name}.zip python
aws lambda publish-layer-version --layer-name {layer_name} --zip-file fileb://{zip-name}.zip --compatible-runtimes python{X.x}