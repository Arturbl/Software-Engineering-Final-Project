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

    selectOne($sql, $params) {
        return new Promise(async (resolve, reject) => {
            try {
                let result = await this.select($sql, $params);
                if (result.length > 0)
                    return resolve(result[0]);
                return resolve(null);
            } catch (e) {
                reject(e);
            }
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

    knex($knex) {
        let query = $knex.toSQL();
        if (query.method === "insert" && query.sql === "")
            return {insertId: null};
        let native = query.toNative();
        return this.query(native.sql, native.bindings);
    }

    async knexOne($knex) {
        let result = await this.knex($knex);
        if (result.length > 0) return result[0];
        return null;
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