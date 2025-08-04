# 📺 Vizio TV Controller Web App

A modern, mobile-first web application for controlling Vizio SmartCast TVs. Built with vanilla HTML, CSS, and JavaScript, this Progressive Web App (PWA) provides an intuitive interface for TV control from any device. **Fully containerized with Docker for easy deployment.**

## ✨ Features

### 🎮 **Core Controls**
- **Power Management**: Turn TV on/off with one tap
- **Volume Control**: Slider and preset buttons for precise volume control
- **Input Switching**: Quick access to HDMI, SmartCast, and other inputs
- **App Launching**: Launch popular streaming apps directly
- **Mute Control**: Instant mute/unmute functionality

### 📱 **Mobile-First Design**
- **Responsive Layout**: Works perfectly on phones, tablets, and desktops
- **Touch-Optimized**: Large buttons and intuitive gestures
- **PWA Support**: Install as a native app on your device
- **Offline Capable**: Basic functionality works without internet

### 🐳 **Containerized Deployment**
- **Docker Support**: Easy deployment with Docker and Docker Compose
- **Environment Variables**: Configure via environment variables
- **Nginx Server**: Production-ready web server
- **Health Checks**: Built-in health monitoring
- **Multi-Platform**: Runs on any platform with Docker

## 🚀 Quick Start

### Prerequisites
1. **Vizio TV**: Any Vizio SmartCast TV
2. **Backend API**: The [vizzy](https://github.com/PasswordHelpMe/vizzy) backend running
3. **Docker**: Docker and Docker Compose installed

### Option 1: Docker Compose (Recommended)

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/vizio-tv-controller-frontend
   cd vizio-tv-controller-frontend
   ```

2. **Configure environment variables**:
   ```bash
   # Copy the example environment file
   cp env.example .env
   
   # Edit the configuration
   nano .env
   ```

3. **Start the application**:
   ```bash
   # Build and start
   docker-compose up --build
   
   # Or run in background
   docker-compose up -d --build
   ```

4. **Access the app**:
   - Open your browser to `http://localhost:8080`
   - The app will automatically connect to your backend

### Option 2: Docker Run

```bash
# Build the image
docker build -t vizio-tv-controller .

# Run with custom configuration
docker run -p 8080:80 \
  -e DEFAULT_API_URL=http://your-backend-ip:8000 \
  -e APP_TITLE="My TV Controller" \
  -e DEBUG_MODE=true \
  vizio-tv-controller
```

### Option 3: Local Development

```bash
# Install dependencies (optional)
npm install

# Start development server
python server.py 8080
# or
npx serve .
```

## ⚙️ Configuration

### Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `DEFAULT_API_URL` | `http://localhost:8000` | Backend API URL |
| `APP_TITLE` | `Vizio TV Controller` | App title |
| `APP_DESCRIPTION` | `Control your Vizio SmartCast TV from any device` | App description |
| `THEME_COLOR` | `#007AFF` | Theme color for PWA |
| `DEBUG_MODE` | `false` | Enable debug logging |
| `AUTO_CONNECT` | `true` | Auto-connect to backend on load |
| `REFRESH_INTERVAL` | `5000` | Status refresh interval (ms) |

### Example Configuration

```bash
# .env file
DEFAULT_API_URL=http://192.168.1.100:8000
APP_TITLE=My TV Controller
APP_DESCRIPTION=Control my living room TV
THEME_COLOR=#FF6B35
DEBUG_MODE=true
AUTO_CONNECT=true
REFRESH_INTERVAL=3000
```

## 🐳 Docker Deployment

### Production Deployment

```bash
# Build production image
docker build -t vizio-tv-controller:latest .

# Run with production settings
docker run -d \
  --name vizio-tv-controller \
  -p 80:80 \
  -e DEFAULT_API_URL=http://your-backend:8000 \
  -e APP_TITLE="TV Controller" \
  --restart unless-stopped \
  vizio-tv-controller:latest
```

### Docker Compose for Production

```yaml
version: '3.8'
services:
  vizio-tv-controller:
    image: vizio-tv-controller:latest
    ports:
      - "80:80"
    environment:
      - DEFAULT_API_URL=http://your-backend:8000
      - APP_TITLE=TV Controller
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "wget", "--quiet", "--tries=1", "--spider", "http://localhost/health"]
      interval: 30s
      timeout: 10s
      retries: 3
```

## 📱 PWA Installation

### iOS (Safari)
1. Open the web app in Safari
2. Tap the **Share** button
3. Select **Add to Home Screen**
4. The app will appear on your home screen

### Android (Chrome)
1. Open the web app in Chrome
2. Tap the **Menu** (three dots)
3. Select **Add to Home screen**
4. Follow the prompts to install

### Desktop (Chrome/Edge)
1. Open the web app in Chrome or Edge
2. Look for the **Install** button in the address bar
3. Click to install the app

## 🎯 Usage Guide

### Power Tab
- **Status Display**: Shows current TV power, volume, input, and mute status
- **Power On/Off**: Large buttons for easy power control
- **Refresh**: Update status manually

### Volume Tab
- **Slider Control**: Drag to set exact volume level
- **Preset Buttons**: Quick access to 25%, 50%, 75%, 100%
- **Mute Controls**: Instant mute/unmute buttons

### Input Tab
- **Input Selection**: Tap any input to switch immediately
- **Current Input**: Shows what input is currently active
- **Common Inputs**: HDMI-1, HDMI-2, SmartCast, Component, AV

### Apps Tab
- **Streaming Apps**: Launch Netflix, YouTube, Prime Video, etc.
- **Quick Access**: One-tap app launching
- **Popular Services**: Pre-configured for common streaming platforms

### Settings Tab
- **API Configuration**: Set your backend URL
- **Connection Testing**: Verify API connectivity
- **Status Information**: View connection and API status
- **Data Refresh**: Manually refresh all TV data

## 🔧 Development

### File Structure
```
vizio-tv-controller/
├── index.html              # Main HTML file
├── styles.css              # CSS styles
├── app.js                  # JavaScript functionality
├── manifest.json           # PWA manifest
├── sw.js                  # Service worker
├── icon.svg               # App icon
├── Dockerfile             # Docker configuration
├── docker-compose.yml     # Docker Compose setup
├── docker-entrypoint.sh   # Container startup script
├── nginx.conf             # Nginx configuration
├── env.example            # Environment variables example
└── README.md              # This file
```

### Building from Source

```bash
# Clone the repository
git clone https://github.com/your-username/vizio-tv-controller-frontend
cd vizio-tv-controller-frontend

# Build Docker image
docker build -t vizio-tv-controller .

# Run locally
docker run -p 8080:80 vizio-tv-controller
```

### Customization

#### Adding New Inputs
Edit the `input-grid` section in `index.html`:
```html
<button class="input-card" onclick="setInput('HDMI-4')">
    <span class="icon">📺</span>
    <span class="label">HDMI-4</span>
</button>
```

#### Adding New Apps
Edit the `apps-grid` section in `index.html`:
```html
<button class="app-card" onclick="launchApp('Disney+')">
    <span class="icon">📺</span>
    <span class="label">Disney+</span>
</button>
```

#### Styling Changes
Modify `styles.css` to customize:
- Colors and themes
- Layout and spacing
- Button styles
- Dark mode appearance

## 🐛 Troubleshooting

### Docker Issues
1. **Port conflicts**: Change the port mapping in docker-compose.yml
2. **Build failures**: Ensure Docker is running and has sufficient resources
3. **Environment variables**: Check that .env file is properly formatted
4. **Container logs**: Use `docker-compose logs` to debug issues

### Connection Issues
1. **Check Backend**: Ensure vizzy is running on the correct port
2. **Network**: Verify both devices are on the same network
3. **Firewall**: Check if firewall is blocking the connection
4. **IP Address**: Use the correct IP address in settings

### App Not Working
1. **Browser Cache**: Clear browser cache and reload
2. **Service Worker**: Unregister and re-register the service worker
3. **Console Errors**: Check browser console for error messages
4. **API Endpoints**: Verify backend endpoints are working

## 🔒 Security Notes

- **Local Network Only**: This app is designed for local network use
- **No Authentication**: The backend API doesn't require authentication
- **CORS**: Ensure your backend allows CORS requests from the web app
- **HTTPS**: For production use, serve over HTTPS

## 📋 Browser Support

- ✅ **Chrome** 60+ (Full PWA support)
- ✅ **Firefox** 60+ (Full PWA support)
- ✅ **Safari** 11.1+ (Limited PWA support)
- ✅ **Edge** 79+ (Full PWA support)
- ✅ **Mobile Browsers** (iOS Safari, Chrome Mobile)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **vizzy Backend**: [PasswordHelpMe/vizzy](https://github.com/PasswordHelpMe/vizzy)
- **Vizio SmartCast API**: For TV control capabilities
- **PWA Standards**: For progressive web app features

## 📞 Support

If you encounter issues:
1. Check the troubleshooting section above
2. Review the browser console for errors
3. Verify your backend is running correctly
4. Test with a simple HTTP request to your API
5. Open an issue on GitHub

---

**Happy TV Controlling! 🎬📺** 