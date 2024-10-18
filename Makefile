LAMBDA_LAYER_NAME = "lambda-layer"
LAMBDA_LAYER_DIR = ./${LAMBDA_LAYER_NAME}
LAMBDA_LAYER_ZIP = ${LAMBDA_LAYER_NAME}.zip
RUNTIME = python3.12
DEPENDENCY = openai

#Targets
.PHONY: all
all: build

.PHONY: build
build:
	#create the lambda layer directory
	mkdir -p $(LAMBDA_LAYER_DIR)/python/lib/$(RUNTIME)/site-packages

	#install the dependencies in the lambda layer directory
	pip install mailtrap -t $(LAMBDA_LAYER_DIR)/python/lib/$(RUNTIME)/site-packages

	#zip the lambda layer directory
	cd $(LAMBDA_LAYER_DIR) && zip -r $(LAMBDA_LAYER_ZIP) .

.PHONY: clean
clean:
	rm -rf $(LAMBDA_LAYER_DIR) $(LAMBDA_LAYER_ZIP)

#Instructions to run: make build
#Instructions to clean: make clean
