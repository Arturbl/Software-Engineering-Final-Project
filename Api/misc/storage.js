const {Storage, StorageType} = require("@tweedegolf/storage-abstraction");

module.exports.createStorage = async function (data, path = "") {
    let config, myStorage;
    config = {
        type: StorageType.LOCAL,
        directory: "./uploads",
        slug: true,
        mode: 488,
    };
    myStorage = new Storage(config);

    return await myStorage.addFileFromBuffer(data, path);
}


module.exports.storageMiddleware = async (req, res) => {
    return res.sendFile(req.url, {
        root: "uploads"
    });
}