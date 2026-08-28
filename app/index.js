const express = require('express');
const mysql = require('mysql2/promise');

const app = express();
const PORT = 3000;

const db = mysql.createPool({
    host: 'mysql-db',
    user: 'root',
    password: '123456',
    database: 'projeto_db'
});

app.get('/categorias', async (req, res) => {
    try {
        const [categorias] = await db.query(
            'SELECT * FROM categorias'
        );

        res.json(categorias);
    } catch (erro) {
        console.error(erro);
        res.status(500).json({ erro: 'Erro ao consultar categorias' });
    }
});

app.get('/produtos', async (req, res) => {
    try {
        const [produtos] = await db.query(`
            SELECT 
                produtos.id,
                produtos.nome,
                produtos.preco,
                produtos.quantidade_estoque,
                categorias.nome AS categoria
            FROM produtos
            INNER JOIN categorias 
                ON produtos.categoria_id = categorias.id
        `);

        res.json(produtos);
    } catch (erro) {
        console.error(erro);
        res.status(500).json({ erro: 'Erro ao consultar produtos' });
    }
});

app.listen(PORT, () => {
    console.log(`Servidor rodando na porta ${PORT}`);
});