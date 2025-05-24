.PHONY: fuzzingserver

fuzzingserver:
	docker run -it --rm \
		-v "${PWD}/fuzzingserver.json:/config/fuzzingserver.json" \
		-v "${PWD}/reports:/reports" \
		-p 9001:9001 \
		--name fuzzingserver \
		crossbario/autobahn-testsuite
