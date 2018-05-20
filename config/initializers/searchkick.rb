
#https://github.com/ankane/searchkick#deployment
#Searchkick uses ENV["ELASTICSEARCH_URL"] for the Elasticsearch server. This defaults to http://localhost:9200
ENV['ELASTICSEARCH_URL'] ||= "http://#{ENV['ELASTICSEARCH_HOST']}:9200" if ENV['ELASTICSEARCH_HOST']
