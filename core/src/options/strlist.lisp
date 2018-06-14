(in-package :net.didierverna.clon)
(in-readtable :net.didierverna.clon)

(defoption strlist ()
  ((argument-name ;; inherited from the VALUED-OPTION class
    :initform "LIST"))
  (:documentation "The STRLIST class.
This class implements options the values of which is a list of strings."))

(defmethod stringify ((sl strlist) value)
  "Transform the LIST's VALUE into an argument."
  (format nil "~{~^ ~}" value))

(defmethod check ((sl strlist) value)
  "Check that VALUE is valid for LIST."
  (if (and (listp value)
           (> (length value) 0)
           (loop for i in value always (stringp i)))
      value
      (error 'invalid-value
             :option sl
             :value value
             :comment "Value must be a list of strings")))

(defmethod convert ((sl strlist) argument)
  (declare (ignore sl))
  argument)


(defun make-strlist (&rest keys
                     &key short-name long-name description argument-name
                       argument-type env-var fallback-value
                       default-value hidden)
  "Make a new comma-separated list of strings option.
- SHORT-NAME is the option's short name (without the dash).
  It defaults to nil.
- LONG-NAME is the option's long name (without the double-dash).
  It defaults to nil.
- DESCRIPTION is the option's description appearing in help strings.
  It defaults to nil.
- ARGUMENT-NAME is the option's argument name appearing in help strings.
- ARGUMENT-TYPE is one of :required, :mandatory or :optional (:required and
  :mandatory are synonyms).
  It defaults to :optional.
- ENV-VAR is the option's associated environment variable.
  It defaults to nil.
- FALLBACK-VALUE is the option's fallback value (for missing optional
  arguments), if any.
- DEFAULT-VALUE is the option's default value, if any.
- When HIDDEN, the option doesn't appear in help strings."
  (declare (ignore short-name long-name description
		   argument-name argument-type
		   env-var fallback-value default-value
		   hidden))
  (apply #'make-instance 'strlist keys))
