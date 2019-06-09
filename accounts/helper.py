
def get_or_create(model, fields):
    objects = model.objects.filter(**fields) 
    if len(objects):
        return objects[0]
    else:
        return model.objects.create(**fields)
