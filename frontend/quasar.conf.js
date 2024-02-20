module.exports = function () {
  return {
    supportTS: false,
    boot: [
      'axios',
      'aws-amplify'
    ],
    css: [
      'app.scss'
    ],
    extras: [
      'roboto-font',
      'material-icons' 
    ],
    build: {
      vueRouterMode: 'hash', 
      env: {
        COGNITO_REGION: process.env.COGNITO_REGION || 'us-east-2',
        COGNITO_USER_POOL_ID: process.env.COGNITO_USER_POOL_ID,
        COGNITO_WEB_CLIENT_ID: process.env.COGNITO_WEB_CLIENT_ID,
        COGNITO_POOL_DOMAIN: process.env.COGNITO_POOL_DOMAIN,
        COGNITO_POOL_REDIRECT_URL: process.env.COGNITO_POOL_REDIRECT_URL,
        API_BASE_URL: process.env.API_BASE_URL
      },
      extendWebpack (cfg) {
        cfg.module.rules.push({
          enforce: 'pre',
          test: /\.(js|vue)$/,
          loader: 'eslint-loader',
          exclude: /node_modules/
        })
      }
    },
    devServer: {
      before (app) {
          const cors = require('cors')
          app.use(cors())
      },
      https: false,
      port: 8080,
      open: true 
    },
    framework: {
      iconSet: 'material-icons', 
      lang: 'en-us', 
      importStrategy: 'auto',
      plugins: ['Notify'],
      config: {
        notify: {
          html: true,
          position: 'top',
          color: 'white',
          timeout: 1000,
          classes: 'q-py-none',
          group: false
        }
      }
    },
    animations: [],
    ssr: {
      pwa: false
    },
    pwa: {
      workboxPluginMode: 'GenerateSW', 
      workboxOptions: {}, 
      manifest: {
        name: 'polyglotvision',
        short_name: 'polyglot',
        description: 'Polyglot Vision',
        display: 'standalone',
        orientation: 'portrait',
        background_color: '#ffffff',
        theme_color: '#027be3',
        icons: [
          {
            src: 'icons/icon-128x128.png',
            sizes: '128x128',
            type: 'image/png'
          },
          {
            src: 'icons/icon-192x192.png',
            sizes: '192x192',
            type: 'image/png'
          },
          {
            src: 'icons/icon-256x256.png',
            sizes: '256x256',
            type: 'image/png'
          },
          {
            src: 'icons/icon-384x384.png',
            sizes: '384x384',
            type: 'image/png'
          },
          {
            src: 'icons/icon-512x512.png',
            sizes: '512x512',
            type: 'image/png'
          }
        ]
      }
    },
    cordova: {
    },
    capacitor: {
      hideSplashscreen: true
    },
    electron: {
      bundler: 'packager', 

      packager: {
      },
      builder: {
        appId: 'polyglotVision'
      },
      nodeIntegration: true,
      extendWebpack () {
      }
    }
  }
}
