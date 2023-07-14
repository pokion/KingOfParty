// const { defineConfig } = require('@vue/cli-service')
// module.exports = defineConfig({
//   transpileDependencies: true
// })
module.exports = {
  configureWebpack: config => {
      config.externals = {
          'better-sqlite3': 'commonjs better-sqlite3'
      };
  },
  pluginOptions: {
      electronBuilder: {
          externals: [ 'better-sqlite3' ]
      }
  }
}
