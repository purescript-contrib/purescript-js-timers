/* no-redeclare global exports */
export function setTimeout(ms) {
  return function (fn) {
    return function () {
      return setTimeout(fn, ms);
    };
  };
}

export function clearTimeout(id) {
  return function () {
    clearTimeout(id);
  };
}

export function setInterval(ms) {
  return function (fn) {
    return function () {
      return setInterval(fn, ms);
    };
  };
}

export function clearInterval(id) {
  return function () {
    clearInterval(id);
  };
}
