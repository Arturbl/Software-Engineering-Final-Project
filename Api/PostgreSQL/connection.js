module.exports = class MyConnection {
    constructor(connection) {
        if (!connection)
            throw new Error("DB_CONN_REQUIRED");
        this.connection = connection;
    }

    select($sql, $params) {
        return new Promise(async (resolve, reject) => {
            this.connection.query($sql, $params, function (err, result) {
                if (err)
                    return reject(err);
                return resolve(result);
            });
        });
    }

    query($sql, $params) {
        return new Promise(async (resolve, reject) => {
            this.connection.query($sql, $params, function (err, result) {
                if (err) return reject({...err, sql: $sql, params: $params});
                return resolve(result);
            });
        });
    }

    async startTransaction() {
        await this.connection.query("START TRANSACTION");
    }

    async commit() {
        await this.connection.query("COMMIT");
    }

    async rollback() {
        await this.connection.query("ROLLBACK");
    }

    async release() {
        await this.connection.release();
    }
};