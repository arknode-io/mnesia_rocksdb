suite=$(if $(SUITE), suite=$(SUITE), )
REBAR3=$(shell which rebar3 || echo ./rebar3)

.PHONY: all check test clean run

export ERLANG_ROCKSDB_OPTS="-DERLANG_ROCKSDB_USE_SYSTEM_ROCKSDB=ON -DERLANG_ROCKSDB_USE_SYSTEM_SNAPPY=ON -DERLANG_ROCKSDB_USE_SYSTEM_LZ4=ON"

all:
	$(REBAR3) compile

docs:
	$(REBAR3) doc

check:
	$(REBAR3) dialyzer

eunit:
	$(REBAR3) eunit $(suite)

ct:
	$(REBAR3) ct $(suite)

test: eunit ct

conf_clean:
	@:

clean:
	$(REBAR3) clean
	$(RM) doc/*

run:
	$(REBAR3) shell
