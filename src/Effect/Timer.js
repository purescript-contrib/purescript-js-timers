/* no-redeclare global exports */
export function setTimeout_(ms) {
  return function (fn) {
    return function () {
      return setTimeout(fn, ms);
    };
  };
}

export function clearTimeout_(id) {
  return function () {
    clearTimeout(id);
  };
}

export function setInterval_(ms) {
  return function (fn) {
    return function () {
      return setInterval(fn, ms);
    };
  };
}

export function clearInterval_(id) {
  return function () {
    clearInterval(id);
  };
}
