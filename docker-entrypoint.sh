#!/bin/sh

# Function to replace environment variables in files
replace_env_vars() {
    echo "🔧 Replacing environment variables..."
    
    # Default values
    DEFAULT_API_URL=${DEFAULT_API_URL:-"http://localhost:8000"}
    APP_TITLE=${APP_TITLE:-"Vizio TV Controller"}
    APP_DESCRIPTION=${APP_DESCRIPTION:-"Control your Vizio SmartCast TV from any device"}
    THEME_COLOR=${THEME_COLOR:-"#007AFF"}
    
    # Replace in app.js
    if [ -f /usr/share/nginx/html/app.js ]; then
        sed -i "s|http://localhost:8000|$DEFAULT_API_URL|g" /usr/share/nginx/html/app.js
        echo "✅ Updated API URL in app.js"
    fi
    
    # Replace in index.html
    if [ -f /usr/share/nginx/html/index.html ]; then
        sed -i "s|<title>Vizio TV Controller</title>|<title>$APP_TITLE</title>|g" /usr/share/nginx/html/index.html
        sed -i "s|content=\"Control your Vizio SmartCast TV from any device\"|content=\"$APP_DESCRIPTION\"|g" /usr/share/nginx/html/index.html
        sed -i "s|content=\"#007AFF\"|content=\"$THEME_COLOR\"|g" /usr/share/nginx/html/index.html
        echo "✅ Updated app metadata in index.html"
    fi
    
    # Replace in manifest.json
    if [ -f /usr/share/nginx/html/manifest.json ]; then
        sed -i "s|\"Vizio TV Controller\"|\"$APP_TITLE\"|g" /usr/share/nginx/html/manifest.json
        sed -i "s|\"Control your Vizio SmartCast TV from any device\"|\"$APP_DESCRIPTION\"|g" /usr/share/nginx/html/manifest.json
        sed -i "s|\"#007AFF\"|\"$THEME_COLOR\"|g" /usr/share/nginx/html/manifest.json
        echo "✅ Updated PWA manifest"
    fi
    
    echo "🎉 Environment variable replacement complete!"
}

# Function to create config.js with environment variables
create_config_js() {
    echo "📝 Creating config.js with environment variables..."
    
    cat > /usr/share/nginx/html/config.js << EOF
// Auto-generated configuration from environment variables
window.VIZIO_CONFIG = {
    DEFAULT_API_URL: '${DEFAULT_API_URL:-"http://localhost:8000"}',
    APP_TITLE: '${APP_TITLE:-"Vizio TV Controller"}',
    APP_DESCRIPTION: '${APP_DESCRIPTION:-"Control your Vizio SmartCast TV from any device"}',
    THEME_COLOR: '${THEME_COLOR:-"#007AFF"}',
    DEBUG_MODE: '${DEBUG_MODE:-"false"}',
    AUTO_CONNECT: '${AUTO_CONNECT:-"true"}',
    REFRESH_INTERVAL: '${REFRESH_INTERVAL:-"5000"}'
};
EOF
    
    echo "✅ Created config.js"
}

# Function to print configuration
print_config() {
    echo "📋 Current Configuration:"
    echo "  API URL: ${DEFAULT_API_URL:-"http://localhost:8000"}"
    echo "  App Title: ${APP_TITLE:-"Vizio TV Controller"}"
    echo "  Theme Color: ${THEME_COLOR:-"#007AFF"}"
    echo "  Debug Mode: ${DEBUG_MODE:-"false"}"
    echo "  Auto Connect: ${AUTO_CONNECT:-"true"}"
    echo "  Refresh Interval: ${REFRESH_INTERVAL:-"5000"}ms"
    echo ""
}

# Main execution
echo "🚀 Starting Vizio TV Controller Web App..."
echo ""

# Print configuration
print_config

# Replace environment variables
replace_env_vars

# Create config.js
create_config_js

# Start nginx
echo "🌐 Starting nginx server..."
exec "$@" 