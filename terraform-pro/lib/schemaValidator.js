module.exports.schemaValidator = function (obj, validator) {
    const errors = validator.validate(obj)
    if (errors.length > 0) throw new Error(errors)
}