#!/usr/bin/env bash

solr create -p 8983 -c vertex_index -shards 1 -replicationFactor 1 
solr create -p 8983 -c edge_index -shards 1 -replicationFactor 1 
solr create -p 8983 -c fulltext_index -shards 1 -replicationFactor 1 