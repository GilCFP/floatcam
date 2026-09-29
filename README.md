# FloatCam 📸

Um aplicativo nativo minimalista para macOS que exibe a sua câmera em uma janela flutuante, ideal para gravações de tela, tutoriais e apresentações.

## ✨ Funcionalidades

- **Sempre no Topo (Always on Top):** A câmera nunca é coberta por outras janelas.
- **Suporte a Tela Cheia:** Funciona perfeitamente mesmo quando você coloca outros aplicativos em *Full Screen* ou muda de Mesa (Spaces).
- **Formatos Personalizáveis:** Escolha entre Círculo, Quadrado, Arredondado ou Losango.
- **Leve e Nativo:** Construído puramente com Swift, SwiftUI e AVFoundation (sem Electron, sem peso extra).
- **Sem Interrupções (Anti-App Nap):** Mantém o vídeo fluindo perfeitamente sem o macOS congelar a janela quando está fora de foco.

## 🚀 Como instalar e usar

Como este é um MVP open-source, você pode compilar o aplicativo diretamente na sua máquina com apenas um comando (você só precisa ter o Xcode Command Line Tools instalado, que já vem com o Mac para desenvolvedores).

1. Clone o repositório:
   ```bash
   git clone https://github.com/GilCFP/floatcam.git
   cd floatcam
   ```

2. Rode o script de build:
   ```bash
   chmod +x build.sh
   ./build.sh
   ```

3. Pronto! O arquivo `FloatCam.app` foi gerado na mesma pasta. Basta dar dois cliques para abrir, ou arrastar para sua pasta de `Aplicativos`.

## 🛠 Como funciona a interface

- **Arrastar:** Clique em qualquer lugar dentro do vídeo e arraste para posicionar a câmera onde quiser na tela.
- **Trocar o Formato:** Clique com o **botão direito** no vídeo para escolher entre os formatos disponíveis.
- **Fechar:** Passe o mouse por cima do vídeo e clique no "X" que aparecerá no canto superior direito, ou clique com o botão direito e escolha "Sair".

## 🔒 Privacidade

O aplicativo solicita permissão de câmera nativa do macOS. Nenhuma imagem ou vídeo é gravado em disco ou enviado para a internet. O aplicativo apenas renderiza a câmera localmente na sua tela.

## 📜 Licença

Sinta-se à vontade para usar, modificar e distribuir. 
