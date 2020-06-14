{
 "configs": [
  {
   "@type": "type.googleapis.com/envoy.admin.v2alpha.BootstrapConfigDump",
   "bootstrap": {
    "node": {
     "build_version": "44f8c365a1f1798f0af776f6aa64279dc68f5666/1.12.1/Clean/RELEASE/BoringSSL"
    },
    "static_resources": {
     "listeners": [
      {
       "name": "prometheus-local",
       "address": {
        "socket_address": {
         "address": "0.0.0.0",
         "port_value": 779
        }
       },
       "filter_chains": [
        {
         "filters": [
          {
           "name": "envoy.http_connection_manager",
           "typed_config": {
            "@type": "type.googleapis.com/envoy.config.filter.network.http_connection_manager.v2.HttpConnectionManager",
            "http_filters": [
             {
              "name": "envoy.router"
             }
            ],
            "route_config": {
             "virtual_hosts": [
              {
               "routes": [
                {
                 "route": {
                  "cluster": "prometheus_cluster"
                 },
                 "match": {
                  "prefix": "/stats/prometheus"
                 }
                }
               ],
               "name": "local_prometheus",
               "domains": [
                "*"
               ]
              }
             ],
             "name": "local_route"
            },
            "stat_prefix": "prometheus",
            "codec_type": "AUTO"
           }
          }
         ]
        }
       ]
      }
     ],
     "clusters": [
      {
       "name": "xds_cluster",
       "type": "STRICT_DNS",
       "connect_timeout": "0.250s",
       "load_assignment": {
        "cluster_name": "xds_cluster",
        "endpoints": [
         {
          "lb_endpoints": [
           {
            "endpoint": {
             "address": {
              "socket_address": {
               "address": "pilot.k8s-manager",
               "port_value": 8080
              }
             }
            }
           }
          ]
         }
        ]
       }
      },
      {
       "name": "xds_grpc_cluster",
       "type": "STRICT_DNS",
       "connect_timeout": "0.250s",
       "http2_protocol_options": {},
       "upstream_connection_options": {
        "tcp_keepalive": {}
       },
       "load_assignment": {
        "cluster_name": "xds_grpc_cluster",
        "endpoints": [
         {
          "lb_endpoints": [
           {
            "endpoint": {
             "address": {
              "socket_address": {
               "address": "pilot.k8s-manager",
               "port_value": 8100
              }
             }
            }
           }
          ]
         }
        ]
       }
      },
      {
       "name": "prometheus_cluster",
       "type": "STRICT_DNS",
       "connect_timeout": "0.250s",
       "load_assignment": {
        "cluster_name": "prometheus_cluster",
        "endpoints": [
         {
          "lb_endpoints": [
           {
            "endpoint": {
             "address": {
              "socket_address": {
               "address": "127.0.0.1",
               "port_value": 1713
              }
             }
            }
           }
          ]
         }
        ]
       }
      },
      {
       "name": "zipkin",
       "type": "STATIC",
       "connect_timeout": "0.250s",
       "load_assignment": {
        "cluster_name": "zipkin",
        "endpoints": [
         {
          "lb_endpoints": [
           {
            "endpoint": {
             "address": {
              "socket_address": {
               "address": "127.0.0.1",
               "port_value": 1111
              }
             }
            }
           }
          ]
         }
        ]
       }
      }
     ]
    },
    "dynamic_resources": {
     "lds_config": {
      "api_config_source": {
       "api_type": "GRPC",
       "grpc_services": [
        {
         "envoy_grpc": {
          "cluster_name": "xds_grpc_cluster"
         }
        }
       ],
       "rate_limit_settings": {
        "max_tokens": 5,
        "fill_rate": 0.1
       }
      }
     },
     "cds_config": {
      "api_config_source": {
       "api_type": "GRPC",
       "grpc_services": [
        {
         "envoy_grpc": {
          "cluster_name": "xds_grpc_cluster"
         }
        }
       ],
       "rate_limit_settings": {
        "max_tokens": 5,
        "fill_rate": 0.1
       }
      }
     }
    },
    "tracing": {
     "http": {
      "name": "envoy.zipkin",
      "typed_config": {
       "@type": "type.googleapis.com/envoy.config.trace.v2.ZipkinConfig",
       "collector_endpoint_version": "HTTP_JSON",
       "collector_endpoint": "/api/v2/spans",
       "collector_cluster": "zipkin"
      }
     }
    },
    "admin": {
     "access_log_path": "/tmp/envoy_admin_access.log",
     "address": {
      "socket_address": {
       "address": "127.0.0.1",
       "port_value": 1713
      }
     }
    }
   },
   "last_updated": "2020-06-14T04:29:18.544Z"
  },
  {
   "@type": "type.googleapis.com/envoy.admin.v2alpha.ClustersConfigDump",
   "version_info": "20200614052815",
   "static_clusters": [
    {
     "cluster": {
      "name": "prometheus_cluster",
      "type": "STRICT_DNS",
      "connect_timeout": "0.250s",
      "load_assignment": {
       "cluster_name": "prometheus_cluster",
       "endpoints": [
        {
         "lb_endpoints": [
          {
           "endpoint": {
            "address": {
             "socket_address": {
              "address": "127.0.0.1",
              "port_value": 1713
             }
            }
           }
          }
         ]
        }
       ]
      }
     },
     "last_updated": "2020-06-14T04:29:18.547Z"
    },
    {
     "cluster": {
      "name": "xds_cluster",
      "type": "STRICT_DNS",
      "connect_timeout": "0.250s",
      "load_assignment": {
       "cluster_name": "xds_cluster",
       "endpoints": [
        {
         "lb_endpoints": [
          {
           "endpoint": {
            "address": {
             "socket_address": {
              "address": "pilot.k8s-manager",
              "port_value": 8080
             }
            }
           }
          }
         ]
        }
       ]
      }
     },
     "last_updated": "2020-06-14T04:29:18.546Z"
    },
    {
     "cluster": {
      "name": "xds_grpc_cluster",
      "type": "STRICT_DNS",
      "connect_timeout": "0.250s",
      "http2_protocol_options": {},
      "upstream_connection_options": {
       "tcp_keepalive": {}
      },
      "load_assignment": {
       "cluster_name": "xds_grpc_cluster",
       "endpoints": [
        {
         "lb_endpoints": [
          {
           "endpoint": {
            "address": {
             "socket_address": {
              "address": "pilot.k8s-manager",
              "port_value": 8100
             }
            }
           }
          }
         ]
        }
       ]
      }
     },
     "last_updated": "2020-06-14T04:29:18.547Z"
    },
    {
     "cluster": {
      "name": "zipkin",
      "type": "STATIC",
      "connect_timeout": "0.250s",
      "load_assignment": {
       "cluster_name": "zipkin",
       "endpoints": [
        {
         "lb_endpoints": [
          {
           "endpoint": {
            "address": {
             "socket_address": {
              "address": "127.0.0.1",
              "port_value": 1111
             }
            }
           }
          }
         ]
        }
       ]
      }
     },
     "last_updated": "2020-06-14T04:29:18.547Z"
    }
   ],
   "dynamic_active_clusters": [
    {
     "version_info": "20200614052815",
     "cluster": {
      "name": "sidecar-testsvc-svc-cluster-http",
      "type": "EDS",
      "eds_cluster_config": {
       "eds_config": {
        "api_config_source": {
         "api_type": "GRPC",
         "grpc_services": [
          {
           "envoy_grpc": {
            "cluster_name": "xds_grpc_cluster"
           }
          }
         ]
        }
       }
      },
      "connect_timeout": "0.100s",
      "circuit_breakers": {
       "thresholds": [
        {
         "max_connections": 2,
         "max_pending_requests": 2
        }
       ]
      },
      "http_protocol_options": {
       "accept_http_10": true
      },
      "outlier_detection": {
       "interval": "1s",
       "base_ejection_time": "600s",
       "max_ejection_percent": 100,
       "success_rate_minimum_hosts": 2,
       "consecutive_gateway_failure": 1,
       "enforcing_consecutive_gateway_failure": 100
      },
      "common_lb_config": {
       "healthy_panic_threshold": {}
      }
     },
     "last_updated": "2020-06-14T05:28:15.207Z"
    },
    {
     "version_info": "20200614052815",
     "cluster": {
      "name": "sidecar-testsvc-svc-cluster-http.__default__.__default__",
      "type": "EDS",
      "eds_cluster_config": {
       "eds_config": {
        "api_config_source": {
         "api_type": "GRPC",
         "grpc_services": [
          {
           "envoy_grpc": {
            "cluster_name": "xds_grpc_cluster"
           }
          }
         ]
        }
       }
      },
      "connect_timeout": "0.100s",
      "circuit_breakers": {
       "thresholds": [
        {
         "max_connections": 2,
         "max_pending_requests": 2
        }
       ]
      },
      "http_protocol_options": {
       "accept_http_10": true
      },
      "outlier_detection": {
       "interval": "1s",
       "base_ejection_time": "600s",
       "max_ejection_percent": 100,
       "success_rate_minimum_hosts": 2,
       "consecutive_gateway_failure": 1,
       "enforcing_consecutive_gateway_failure": 100
      },
      "common_lb_config": {
       "healthy_panic_threshold": {}
      }
     },
     "last_updated": "2020-06-14T05:28:15.207Z"
    }
   ]
  },
  {
   "@type": "type.googleapis.com/envoy.admin.v2alpha.ListenersConfigDump",
   "version_info": "20200614042917",
   "static_listeners": [
    {
     "listener": {
      "name": "prometheus-local",
      "address": {
       "socket_address": {
        "address": "0.0.0.0",
        "port_value": 779
       }
      },
      "filter_chains": [
       {
        "filters": [
         {
          "name": "envoy.http_connection_manager",
          "typed_config": {
           "@type": "type.googleapis.com/envoy.config.filter.network.http_connection_manager.v2.HttpConnectionManager",
           "http_filters": [
            {
             "name": "envoy.router"
            }
           ],
           "route_config": {
            "virtual_hosts": [
             {
              "routes": [
               {
                "route": {
                 "cluster": "prometheus_cluster"
                },
                "match": {
                 "prefix": "/stats/prometheus"
                }
               }
              ],
              "name": "local_prometheus",
              "domains": [
               "*"
              ]
             }
            ],
            "name": "local_route"
           },
           "stat_prefix": "prometheus",
           "codec_type": "AUTO"
          }
         }
        ]
       }
      ]
     },
     "last_updated": "2020-06-14T04:29:18.549Z"
    }
   ],
   "dynamic_active_listeners": [
    {
     "version_info": "20200614042917",
     "listener": {
      "name": "sidecar-testsvc-svc-listener-http",
      "address": {
       "socket_address": {
        "address": "0.0.0.0",
        "port_value": 902
       }
      },
      "filter_chains": [
       {
        "filters": [
         {
          "name": "envoy.http_connection_manager",
          "typed_config": {
           "@type": "type.googleapis.com/envoy.config.filter.network.http_connection_manager.v2.HttpConnectionManager",
           "stat_prefix": "sidecar-testsvc-svc-http",
           "http_filters": [
            {
             "name": "envoy.router"
            }
           ],
           "http_protocol_options": {
            "accept_http_10": true
           },
           "access_log": [
            {
             "name": "envoy.file_access_log",
             "typed_config": {
              "@type": "type.googleapis.com/envoy.config.accesslog.v2.FileAccessLog",
              "path": "/tmp/arsenal_access_svc.log",
              "format": "[%START_TIME(%d/%b/%Y:%H:%M:%S %z)%] [%DOWNSTREAM_REMOTE_ADDRESS_WITHOUT_PORT%] [-] [%REQ(:METHOD)% %REQ(X-ENVOY-ORIGINAL-PATH?:PATH)% %PROTOCOL%] [%RESPONSE_CODE%] [%BYTES_SENT%] [-] [%REQ(USER-AGENT)%] [%REQ(X-FORWARDED-FOR)%] [%DURATION%] [%UPSTREAM_HOST%] [%RESPONSE_DURATION%] [sidecar-testsvc-svc:902] [-] [%REQ(X-ENVOY-ORIGINAL-PATH?:PATH)%] [-] [sidecar-testsvc-svc] [resp_flags:%RESPONSE_FLAGS%,x-req-id:%REQ(X-REQUEST-ID)%]\n"
             }
            }
           ],
           "rds": {
            "config_source": {
             "api_config_source": {
              "api_type": "GRPC",
              "grpc_services": [
               {
                "envoy_grpc": {
                 "cluster_name": "xds_grpc_cluster"
                }
               }
              ]
             }
            },
            "route_config_name": "sidecar-testsvc-svc-route-http"
           }
          }
         }
        ]
       }
      ]
     },
     "last_updated": "2020-06-14T04:29:18.557Z"
    }
   ]
  },
  {
   "@type": "type.googleapis.com/envoy.admin.v2alpha.ScopedRoutesConfigDump"
  },
  {
   "@type": "type.googleapis.com/envoy.admin.v2alpha.RoutesConfigDump",
   "static_route_configs": [
    {
     "route_config": {
      "name": "local_route",
      "virtual_hosts": [
       {
        "name": "local_prometheus",
        "domains": [
         "*"
        ],
        "routes": [
         {
          "match": {
           "prefix": "/stats/prometheus"
          },
          "route": {
           "cluster": "prometheus_cluster"
          }
         }
        ]
       }
      ]
     },
     "last_updated": "2020-06-14T04:29:18.548Z"
    }
   ],
   "dynamic_route_configs": [
    {
     "version_info": "20200614050932",
     "route_config": {
      "name": "sidecar-testsvc-svc-route-http",
      "virtual_hosts": [
       {
        "name": "sidecar-testsvc-svc",
        "domains": [
         "*"
        ],
        "routes": [
         {
          "match": {
           "prefix": "/"
          },
          "route": {
           "cluster": "sidecar-testsvc-svc-cluster-http.__default__.__default__",
           "timeout": "0s",
           "retry_policy": {
            "retry_on": "connect-failure"
           }
          }
         }
        ],
        "request_headers_to_add": [
         {
          "header": {
           "key": "Host",
           "value": "sidecar-testsvc-svc"
          },
          "append": false
         }
        ]
       }
      ]
     },
     "last_updated": "2020-06-14T05:09:32.198Z"
    }
   ]
  },
  {
   "@type": "type.googleapis.com/envoy.admin.v2alpha.SecretsConfigDump"
  }
 ]
}
