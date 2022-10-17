const esbuild = require('esbuild');

const isProd = process.env.NODE_ENV === 'production'

esbuild.build({
    entryPoints: ['src/index.jsx'],
    nodePaths: [process.env.NODE_PATH],
    bundle: true,
    outdir: "dist",
    minify: isProd,
    watch: process.argv.includes('--watch'),
    plugins: [],
}).catch(_e => process.exit(1))