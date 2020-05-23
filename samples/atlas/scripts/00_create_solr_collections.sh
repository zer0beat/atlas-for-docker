#!/usr/bin/env bash

curl 'http://solr:8983/solr/admin/collections?action=CREATE&name=vertex_index&numShards=1&collection.configName=atlas'
curl 'http://solr:8983/solr/admin/collections?action=CREATE&name=edge_index&numShards=1&collection.configName=atlas'
curl 'http://solr:8983/solr/admin/collections?action=CREATE&name=fulltext_index&numShards=1&collection.configName=atlas'