module.exports = {

  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,        // Port 7545 for Ganache-UI, Port 8545 for Ganache-CLI
      network_id: "*"    // Match any network id
    }
  }
};
