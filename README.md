# Desafio Backend Jr com Ruby on Rails (Mainô)

## Como Rodar o Projeto Localmente

Siga os passos abaixo para configurar e rodar o projeto em sua máquina local.

### 1. Configurações

1. **Configurar credenciais do banco de dados (Postgres) e Redis:**
   - Crie um arquivo `.env` na raiz do projeto com as configurações necessárias para o banco de dados e Redis.
   - Utilize o arquivo de exemplo disponível na raiz do projeto (`.env.example`) para facilitar a configuração.

2. **Instalar dependências:**
   - Execute o comando abaixo para instalar todas as dependências necessárias:
     ```bash
     bundle install
     ```

3. **Configurar o banco de dados:**
   - Execute o seguinte comando para configurar o banco de dados:
     ```bash
     rails db:setup
     ```

### 2. Rodando o Servidor

Para iniciar o servidor local, utilize o comando abaixo:

```bash
bin/dev
```

Parabéns! A aplicação já está configurada e rodando. Você pode acessá-la através do caminho `http://localhost:5000` (por padrão).

Obrigado por utilizar o projeto! Se precisar de mais informações ou tiver dúvidas, não hesite em entrar em contato.
