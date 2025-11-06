# 🐄 Cuidado Pecuário - Sistema de Gestão de Rebanho

![Flutter](https://img.shields.io/badge/Flutter-3.19-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.0-blue?logo=dart)
![License](https://img.shields.io/badge/License-MIT-green)

Um aplicativo moderno e intuitivo para gestão de rebanho bovino, desenvolvido em Flutter com foco na experiência do usuário e organização modular.

## 📱 Demonstração

### Telas Principais
| Lista de Animais | Perfil do Animal | Cadastro | Status do Banco |
|------------------|------------------|----------|-----------------|
| <img src="https://via.placeholder.com/250x500/4CAF50/FFFFFF?text=Lista+Animais" width="200"> | <img src="https://via.placeholder.com/250x500/2196F3/FFFFFF?text=Perfil+Animal" width="200"> | <img src="https://via.placeholder.com/250x500/FF9800/FFFFFF?text=Cadastro" width="200"> | <img src="https://via.placeholder.com/250x500/9C27B0/FFFFFF?text=Status+Banco" width="200"> |

## ✨ Funcionalidades

### 🐮 Gestão de Animais
- ✅ **Cadastro completo** de animais com todos os dados zootécnicos
- ✅ **Lista inteligente** com filtros por status de saúde
- ✅ **Perfil detalhado** com informações completas do animal
- ✅ **Edição em tempo real** dos dados cadastrais
- ✅ **Exclusão segura** com confirmação

### 🏥 Controle de Saúde
- ✅ **Status de saúde** (Saudável, Em tratamento, Doente)
- ✅ **Controle de peso** e evolução corporal
- ✅ **Histórico de cuidados** veterinários
- ✅ **Último cuidado** registrado automaticamente

### 📊 Estatísticas e Relatórios
- ✅ **Dashboard completo** com métricas do rebanho
- ✅ **Status do banco de dados** em tempo real
- ✅ **Relatórios de saúde** por categoria
- ✅ **Contagem automática** por status

### 💾 Persistência de Dados
- ✅ **Banco de dados local** com SQLite
- ✅ **Operações CRUD** completas
- ✅ **DAOs especializados** para cada entidade
- ✅ **Estrutura modular** e escalável

## 🛠️ Tecnologias Utilizadas

- **Flutter 3.19** - Framework principal
- **Dart 3.0** - Linguagem de programação
- **SQLite** - Banco de dados local
- **Google Fonts** - Tipografia moderna
- **Intl** - Formatação de datas e valores

## 🏗️ Estrutura do Projeto

```
lib/
├── main.dart                 # Ponto de entrada do app
├── components/               # Widgets reutilizáveis
│   ├── animal_editor.dart   # Editor de animais
│   ├── health_card.dart     # Card de saúde
│   └── custom_button.dart   # Botões customizados
├── models/                   # Modelos de dados
│   ├── animal.dart          # Modelo Animal
│   └── cuidado.dart         # Modelo Cuidado
├── database/                 # Camada de dados
│   ├── app_database.dart    # Configuração do banco
│   └── dao/                 # Data Access Objects
│       ├── animal_dao.dart  # DAO para animais
│       └── cuidado_dao.dart # DAO para cuidados
└── screens/                  # Telas do aplicativo
    ├── animais/
    │   ├── lista_animais.dart      # Lista principal
    │   ├── formulario_animal.dart  # Cadastro/edição
    │   └── perfil_animal.dart      # Perfil detalhado
    ├── cuidados/                    # Gestão de cuidados
    └── status_database/            # Status do banco
        └── status_database.dart
```

## 🚀 Como Executar

### Pré-requisitos
- Flutter SDK 3.19 ou superior
- Dart 3.0 ou superior
- Dispositivo/Emulador ou navegador web

### Instalação
```bash
# Clone o repositório
git clone https://github.com/seu-usuario/cuidado-pecuario.git

# Entre no diretório
cd cuidado-pecuario

# Instale as dependências
flutter pub get

# Execute o aplicativo
flutter run
```

### Comandos Úteis
```bash
# Limpar e reinstalar
flutter clean && flutter pub get

# Executar em modo debug
flutter run

# Build para web
flutter build web

# Testar o aplicativo
flutter test
```

## 📋 Requisitos Atendidos

### ✅ Funcionalidades Obrigatórias
- [x] **Tela Inicial** - Lista de animais com FutureBuilder
- [x] **Tela de Formulário** - Cadastro com validações
- [x] **Persistência SQLite** - CRUD completo com DAOs
- [x] **Tela de Status** - Informações do banco de dados
- [x] **Navegação** - Navigator.push/pop entre telas
- [x] **Tema Global** - ThemeData com Material 3
- [x] **Formatação** - Intl para datas e valores

### ✅ Conceitos Técnicos
- [x] **StatelessWidget** - Componentes reutilizáveis
- [x] **StatefulWidget** - Telas com estado
- [x] **TextEditingController** - Controle de formulários
- [x] **setState** - Atualização de interface
- [x] **Estrutura Modular** - Organização em pastas
- [x] **FutureBuilder** - Carregamento assíncrono

## 🎨 Design System

### Cores Principais
```dart
ColorScheme.fromSeed(
  seedColor: Colors.green,
  primary: Colors.green,
  secondary: Colors.brown[400]!,
)
```

### Tipografia
- **Google Fonts Inter** - Fonte principal
- **Hierarquia clara** de títulos e textos
- **Cores semânticas** para status

### Componentes
- **Cards arredondados** com sombras suaves
- **Botões com ícones** para melhor UX
- **Formulários organizados** em seções
- **Feedback visual** consistente

## 📈 Estatísticas do Projeto

- **✅ 100% dos requisitos** atendidos
- **🎯 15+ componentes** reutilizáveis
- **📱 5 telas principais** implementadas
- **💾 2 modelos de dados** estruturados
- **🔧 2 DAOs especializados** criados

## 🤝 Contribuição

Contribuições são bem-vindas! Siga estos passos:

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para detalhes.

## 👨‍💻 Desenvolvido por

[Seu Nome] - [seu.email@exemplo.com]

---

**⭐️ Se este projeto te ajudou, deixe uma estrela no repositório!**

## 🔄 Histórico de Versões

### v1.0.0 (2024)
- ✅ Versão inicial completa
- ✅ Todas as funcionalidades obrigatórias
- ✅ Design moderno e responsivo
- ✅ Persistência de dados local

---

**🐄 Cuidado Pecuário - Gestão Inteligente do Seu Rebanho**


---

## 👥 Authors

* Habbiner Andrade
* Éllen Dias
* Leonardo Cassio
* Gabriel Fillip

```
```
