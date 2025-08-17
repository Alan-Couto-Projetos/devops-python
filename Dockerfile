# Dockerfile
FROM python:3.11-slim

# Define o diretório de trabalho dentro do contêiner.
WORKDIR /app

# Copia o arquivo de requisitos e instala as dependências.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia todo o conteúdo do diretório atual (onde o Dockerfile está)
# para o diretório de trabalho (/app) dentro do contêiner.
COPY . .

# Comando que será executado quando o contêiner iniciar.
# O caminho agora reflete a estrutura de diretórios correta.
CMD ["python", "devops/app/main.py"]