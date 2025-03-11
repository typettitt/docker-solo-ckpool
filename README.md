# docker-solo-ckpool

Run your own ckpool solo instance in a docker container

## First steps

1. Install Docker (see https://docs.docker.com/engine/install/ for details)
2. Clone this repository: `git clone https://github.com/typettitt/docker-solo-ckpool.git`
3. Build the container image with `./build_image.sh` or use a custom build command: `docker build -t docker-ckpool:latest .`

### Configuration
The pool configuration file is located in `conf/ckpool.conf`. You need to amend the pool configuration for your bitcoind instance. At a minimum, below are the details for the properties you need to set:

- `url`: The URL of your bitcoind RPC interface. Replace `<BITCOIND_HOST>` with the hostname or IP address of your bitcoind instance. Example: `http://192.168.1.54:8332`, `http://localhost:8332` or `http://umbrel.local:8332`
- `auth`: The RPC username for your bitcoind instance. Replace `<RPC_USER>` with your actual RPC username.
- `pass`: The RPC password for your bitcoind instance. Replace `<RPC_PASSWORD>` with your actual RPC password.
- `notify`: Set to `true` to enable notifications.
- `btcsig`: A custom signature for your pool. Replace `<CUSTOM_COINBASE_SIGNATURE>` with your desired signature. Example: `"/mined by docker-solo-ckpool/"`

Example configuration:

```json
{
    "btcd": [
        {
            "url": "http://<BITCOIND_HOST>:8332",
            "auth": "<RPC_USER>",
            "pass": "<RPC_PASSWORD>",
            "notify": true
        }
    ],
    "btcsig": "<CUSTOM_COINBASE_SIGNATURE>",
    "blockpoll": 100,
    "donaddress": "bc1q2f9lvvszfse2mzphse5u08hg9xqmn3j068mahr",
    "donation": 2,
    "nonce1length": 4,
    "nonce2length": 8,
    "update_interval": 30,
    "version_mask": "1fffe000",
    "mindiff": 1,
    "startdiff": 42,
    "maxdiff": 0,
    "zmqblock": "tcp://127.0.0.1:28332",
    "logdir": "logs"
}
```

- `blockpoll`: The interval in milliseconds to poll for new blocks. Default is `100`.
- `donation`: The donation percentage. Set to `0` to disable donations or set to your desired percentage.
- `nonce1length`: The length of the first part of the nonce. Default is `4`.
- `nonce2length`: The length of the second part of the nonce. Default is `8`.
- `update_interval`: The interval in seconds to update the pool status. Default is `30`.
- `version_mask`: The version mask for the block version. Default is `"1fffe000"`.
- `mindiff`: The minimum difficulty. Default is `1`.
- `startdiff`: The starting difficulty. Default is `42`.
- `maxdiff`: The maximum difficulty. Set to `0` for no limit.
- `zmqblock`: The ZMQ address for block notifications. Example: `tcp://127.0.0.1:28332`
- `logdir`: The directory for log files. Default is `"logs"`.

To make a local bitcoind available to the docker container, add these two lines to `bitcoin.conf` to bind it to the docker host gateway address:

`rpcbind=172.17.0.1`

`zmqpubhashblock=tcp://172.17.0.1:28332`


### Container quick-start

- Create and start the container with `docker compose up -d`

- To stop the container use `docker compose stop`
- To start the container use `docker compose start`

- Whenever you need to change the ckpool configuration, stop the container first. Once done with your changes, start the container again.

- To destroy the container (if needed), use `docker compose down`

### Connect your miners to ckpool

By default, the ckpool container is listening on port 3333. Depending on your setup, either use localhost or the IP address of the docker host in the stratum URL to connect your miners:

`stratum+tcp://localhost:3333`

OR

`stratum+tcp://<HOST_IP>:3333`

### Credits

This project is based on the original work by [golden-guy](https://github.com/golden-guy):

- [docker-ckpool](https://github.com/golden-guy/docker-ckpool)
- [ckpool-solo](https://github.com/golden-guy/ckpool-solo)