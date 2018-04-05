import resolve from 'rollup-plugin-node-resolve';
import commonjs from 'rollup-plugin-commonjs';

export default {
  input: 'src/zip.bs.js',
  output: {
    file: 'index.js',
    format: 'cjs'
  },
  exports: 'named',
  name: 'Zip',
  external: ['jszip'],
  plugins: [
    resolve(),
    commonjs()
  ]
}
