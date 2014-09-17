var gulp = require('gulp');
var coffee = require('gulp-coffee');
var sourcemaps = require('gulp-sourcemaps');
var notify = require('gulp-notify');
var del = require('del');

gulp.task('default', ['clean', 'coffee']);

gulp.task('coffee', function() {
  gulp.src('./src/**/*.coffee')
    .pipe(sourcemaps.init())
    .pipe(coffee({})).on('error', console.log)
    .pipe(notify())
    .pipe(sourcemaps.write('./maps'))
    .pipe(gulp.dest('build'));
});

gulp.task('clean', function(cb) {
  del(['build/'], cb);
});

gulp.task('watch', function() {
  gulp.watch([
    // 'src/*.coffee',
    'src/**/*.coffee'
    ], ['clean', 'coffee']);
});

