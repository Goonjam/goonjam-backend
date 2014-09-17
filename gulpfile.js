var gulp = require('gulp');
var coffee = require('gulp-coffee');
var sourcemaps = require('gulp-sourcemaps');

gulp.task('default', ['coffee']);

gulp.task('coffee', function() {
  gulp.src('./src/*.coffee')
    .pipe(sourcemaps.init())
    .pipe(coffee({}))//.on('error', gutil.log)
    .pipe(sourcemaps.write('./maps'))
    .pipe(gulp.dest('./build'));
});

gulp.task('watch', function() {
  gulp.watch([
    // 'src/*.coffee',
    'src/**/*.coffee'
    ], ['coffee']);
});
