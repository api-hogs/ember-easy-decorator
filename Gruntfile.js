module.exports = function(grunt) {
  grunt.initConfig({
    coffee: {
      compile: {
        files: {
          'ember-easy-decorator.js': 'ember-easy-decorator.coffee'
        }
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-coffee');

//  grunt.registerTask('test', 'qunit');
};