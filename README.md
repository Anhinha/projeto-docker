# Lanchonete - Node + MySQL com Docker

Projeto desenvolvido para a atividade avaliativa de DevOps & Cloud Computing.

## Estrutura

O projeto utiliza dois containers:

- Node/Express: responsável pela aplicação.
- MySQL: responsável pelo banco de dados.

Os containers se comunicam através da rede Docker `rede-docker`.

Fluxo:

Cliente → Node/Express → MySQL

## Configurações

- Rede Docker: `rede-docker`
- Container MySQL: `mysql-db`
- Container Node: `node-app`
- Banco de dados: `projeto_db`
- Porta da aplicação: `3000`
- Volume: `mysql-dados`
- Memória dos containers: `128 MB`
- CPU dos containers: `0.2`

## Banco de dados

O banco possui duas tabelas:

### Categorias

- id
- nome
- descricao
- ativo
- criado_em

### Produtos

- id
- nome
- preco
- quantidade_estoque
- categoria_id

A tabela `produtos` possui uma chave estrangeira relacionada à tabela `categorias`.

O arquivo `banco/banco.sql` contém a criação das tabelas e os dados utilizados no projeto.

## Aplicação

A aplicação foi desenvolvida com Node.js e Express.

### GET /categorias

Retorna todas as categorias cadastradas no banco de dados.

Acesse:

http://localhost:3000/categorias

### GET /produtos

Retorna os produtos cadastrados juntamente com o nome de suas respectivas categorias.

A consulta utiliza um `INNER JOIN` entre as tabelas `produtos` e `categorias`.

Acesse:

http://localhost:3000/produtos

## Comunicação entre os containers

O Node acessa o MySQL utilizando o nome do container como hostname:

`mysql-db`

Não é utilizado IP fixo para a comunicação.

Os dois containers estão conectados à rede Docker:

`rede-docker`

## Como executar

### 1. Criar a rede

```powershell
docker network create rede-docker
```

### 2-Criar o volume

```powershell
docker volume create mysql-dados
```

### 3-Criar o container MySQL

```powershell
docker run -d `
  --name mysql-db `
  --network rede-docker `
  --memory=128m `
  --cpus=0.2 `
  -e MYSQL_ROOT_PASSWORD=123456 `
  -e MYSQL_DATABASE=projeto_db `
  -v mysql-dados:/var/lib/mysql `
  mysql:latest
```

### 4-Criar a imagem da aplicação Node:

```powershell
docker build -t lanchonete-node ./app
```

### 5-Criar o container Node

```powershell
docker run -d `
  --name node-app `
  --network rede-docker `
  --memory=128m `
  --cpus=0.2 `
  -p 3000:3000 `
  lanchonete-node
```
### 6-Verificar os containers

```powershell
docker ps
```

### 7-Verificar a rede

```powershell
docker network inspect rede-docker
```

### 8-verificar o volume

```powershell
docker volume inspect mysql-dados
```

### 9-Testar a rota de categorias

```powershell
curl.exe http://localhost:3000/categorias
```

### 10-Testar a rota de produtos

```powershell
curl.exe http://localhost:3000/produtos
```

Como recriar o banco de dados

O arquivo banco/banco.sql contém a estrutura das tabelas e os registros utilizados no projeto.

Para acessar o MySQL pelo container:
docker exec -it mysql-db mysql -uroot -p123456 projeto_db

Para executar o arquivo SQL:
docker exec -i mysql-db mysql -uroot -p123456 projeto_db < banco/banco.sql

Recursos utilizados

* Docker
* Node.js
* Express
* MySQL
* Docker Network
* Docker Volume

Funcionamento

O cliente acessa a aplicação através da porta 3000.

O Node/Express recebe a requisição e consulta o banco MySQL através da rede Docker rede-docker.

A comunicação entre os containers é realizada utilizando o nome mysql-db como hostname, sem utilizar IP fixo.

O fluxo da aplicação é:

Cliente → Node/Express → MySQL

As rotas /categorias e /produtos retornam os dados armazenados no banco em formato JSON.

A rota /produtos utiliza um INNER JOIN para relacionar os produtos às suas respectivas categorias.

Node e MySQL foram executados em containers separados e conectados através de uma rede Docker própria para o projeto.```