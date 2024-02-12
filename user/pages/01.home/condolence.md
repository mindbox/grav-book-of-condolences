---
title: Thank you, Jane.
cache_enable: false
visible: false

process:
  twig: true

image: lucas-wesney-ZNz5UPRb2N8-unsplash.jpg
media_order: 'lucas-wesney-ZNz5UPRb2N8-unsplash.jpg,paul-garaizar-lw9LrnpUmWw-unsplash.jpg'

form:
  name: condolence
  action: "#condolence"
  refresh_prevention: true
  template: form-messages
  classes: form
  fields:
    name:
      id: field-name
      type: text
      label: THEME_C.FORM.FIELD.NAME
      autocomplete: off
      outerclasses: levitate
      validate:
        required: true

    message:
      id: field-message
      type: textarea
      label: THEME_C.FORM.FIELD.MESSAGE
      rows: 4
      outerclasses: levitate
      validate:
        required: true

    # personality:
    #   id: field-personality
    #   outerclasses: text-input
    #   label: THEME_C.FORM.FIELD.SPAM_Q
    #   type: radio
    #   options:
    #     berlin: Berlin
    #     paris: Paris
    #     newyork: New York
    #   validate:
    #     required: true
    #     pattern: "^paris$"
    #     message: THEME_C.FORM.FIELD.SPAM_FAIL

    honeypot:
      type: honeypot

    privacy_info:
      type: display
      label: false
      markdown: true
      dated: true
      classes: textflow
      outerclasses: privacy-policy textflow
      content: THEME_C.FORM.PRIVACY

    privacy:
      id: field-privacy
      type: checkbox
      label: THEME_C.FORM.FIELD.DSGVO
      validate:
        required: true

  buttons:
    - type: submit
      value: THEME_C.FORM.FIELD.SUBMIT
      classes: button--secondary

  process:
    condolence: true
    message: THEME_C.FORM.THANKS
    reset: true

---

Jane Doe shaped our community for over 30 years. She worked for the charity until her unexpected departure. She contributed her extensive and profound expertise with tireless dedication and passionately conveyed the spirit of empathy and care. 

Our sincere condolences and deepest sympathy go out to the bereaved. We mourn the loss of an outstanding personality who put her passion and energy at the service of her family and company. We will always remember her valuable contribution and keep her in honorable and grateful memory. 

In this digital book of condolence, everyone has the opportunity to say goodbye to Jane Doe in a personal way. Dear Jane - we will miss you very much! Rest in peace.