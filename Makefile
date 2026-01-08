PREFIX_DIR := /usr/local/bin

build:
	@echo "Building the Raptor command-line tool...\\n"
	@swift build -c release --product RaptorCLI

install:
	@echo "Installing the Raptor command-line tool...\\n"
	@mkdir -p $(PREFIX_DIR) 2> /dev/null || ( echo "❌ Unable to create install directory \`$(PREFIX_DIR)\`. You might need to run \`sudo make\`\\n"; exit 126 )
	@(install .build/release/RaptorCLI $(PREFIX_DIR)/raptor && \
	  install ./server.py $(PREFIX_DIR)/raptor-server.py && \
	  chmod +x $(PREFIX_DIR)/raptor && \
	  (echo \\n✅ Success! Run \`raptor\` to get started.)) || \
	 (echo \\n❌ Installation failed. You might need to run \`sudo make\` instead.\\n)

clean:
	@echo "Cleaning the Raptor build folder...\\n"
	@rm -rf .build/
