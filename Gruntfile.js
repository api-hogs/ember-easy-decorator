module.exports = function(grunt) {
  grunt.initConfig({
    coffee: {
      compile: {
        files: {
          'dist/ember-easy-decorator.js': 'src/ember-easy-decorator.coffee'
        }
      }
    },
    qunit: {
      all: ['tests/*.html']
    }
  });

  grunt.registerTask('test', 'qunit');
  grunt.registerTask('default', 'coffee');

  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-qunit');
};