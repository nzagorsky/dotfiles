
install_confluent_kafka() {
	brew install librdkafka
	VERSION=$(brew info --json=v1 librdkafka | jq ".[0].linked_keg" --raw-output)

	export C_INCLUDE_PATH=/opt/homebrew/Cellar/librdkafka/$VERSION/include
	export LIBRARY_PATH=/opt/homebrew/Cellar/librdkafka/$VERSION/lib

	pip install confluent-kafka
}
