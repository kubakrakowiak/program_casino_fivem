INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES ('society_casino', 'Kasyno', 1);

INSERT INTO `addon_account_data` (`account_name`, `money`, `owner`) VALUES ('society_casino', 771420, NULL);

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES ('society_casino', 'Kasyno', 1);

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES ('society_casino_fridge', 'Casino (lodowka)', 1);

INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES ('society_casino', 'Kasyno', 1);

INSERT INTO `datastore_data` (`name`, `owner`, `data`) VALUES ('society_casino', NULL, '{}');


INSERT INTO `items` (`name`, `label`, `limit`) VALUES  
    ('jager', 'Jägermeister', 5),
    ('vodka', 'Vodka', 5),
    ('rhum', 'Rum', 5),
    ('whisky', 'Whisky', 5),
    ('tequila', 'Tequila', 5),
    ('martini', 'Martini bianco', 5),
    ('soda', 'Woda', 5),
    ('jusfruit', 'Jus de fruits', 5),
    ('icetea', 'Ice Tea', 5),
    ('energy', 'Energy Drink', 5),
    ('drpepper', 'Dr. Pepper', 5),
    ('limonade', 'Lemoniada', 5),
    ('bolcacahuetes', 'Miska orzeszków ziemnych', 5),
    ('bolnoixcajou', 'Miska orzechów nerkowca', 5),
    ('bolpistache', 'Miska pistacji', 5),
    ('bolchips', 'Miska Chipsów', 5),
    ('saucisson', 'Kiełbasa', 5),
    ('grapperaisin', 'Kiść winogron', 5),
    ('jagerbomb', 'Jägerbomb', 5),
    ('golem', 'Golem', 5),
    ('whiskycoca', 'Whisky-cola', 5),
    ('vodkaenergy', 'Vodka-energetyk', 5),
    ('vodkafruit', 'Vodka-sok owocowy', 5),
    ('rhumfruit', 'Rum-sok owocowy', 5),
    ('teqpaf', "Teq'paf", 5),
    ('rhumcoca', 'Rum-cola', 5),
    ('mojito', 'Mojito', 5),
    ('ice', 'Lód', 5),
    ('mixapero', 'Mix Apéritif', 3),
    ('metreshooter', 'Mètre de shooter', 3),
    ('jagercerbere', 'Jäger Cerbère', 3),
    ('menthe', 'Liść mięty', 10)
;

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES ('casino', 'Kasyno', 1);

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES ('casino', 0, 'guard', 'Ochroniarz', 70, '{"torso_1":95,"helmet_2":2,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":15,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":0,"age_2":0,"glasses_2":6,"ears_2":0,"arms":26,"lipstick_1":0,"ears_1":0,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":58,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":17,"bproof_1":0,"mask_1":0,"decals_1":45,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":1,"eyebrows_1":0,"face":0,"shoes_1":21,"pants_1":24}', '{"torso_1":124,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":15,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":1,"age_2":0,"glasses_2":6,"ears_2":0,"arms":14,"lipstick_1":0,"ears_1":0,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":-1,"shoes_2":4,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":5,"bproof_1":0,"mask_1":0,"decals_1":45,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":2,"eyebrows_1":0,"face":0,"shoes_1":42,"pants_1":65}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES ('casino', 1, 'croupier', 'Krupier', 100, '{"hair_2":0,"hair_color_2":0,"torso_1":11,"bags_1":0,"helmet_2":0,"chain_2":2,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":22,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":11,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":0,"age_2":0,"glasses_2":11,"ears_2":0,"arms":75,"lipstick_1":0,"ears_1":0,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":-1,"shoes_2":4,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":3,"bproof_1":0,"mask_1":0,"decals_1":0,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":4,"skin":0,"torso_2":1,"eyebrows_1":0,"face":0,"shoes_1":3,"pants_1":24}', '{"torso_1":124,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":15,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":1,"age_2":0,"glasses_2":6,"ears_2":0,"arms":14,"lipstick_1":0,"ears_1":0,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":-1,"shoes_2":4,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":5,"bproof_1":0,"mask_1":0,"decals_1":45,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":2,"eyebrows_1":0,"face":0,"shoes_1":42,"pants_1":65}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES ('casino', 2, 'boss', 'Właściciel Kasyna', 0, '{"hair_2":0,"hair_color_2":0,"torso_1":29,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":31,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":4,"age_2":0,"glasses_2":0,"ears_2":0,"arms":1,"lipstick_1":0,"ears_1":0,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":0,"bproof_1":0,"mask_1":0,"decals_1":0,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":4,"eyebrows_1":0,"face":0,"shoes_1":10,"pants_1":24}', '{"torso_1":124,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":15,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":1,"age_2":0,"glasses_2":6,"ears_2":0,"arms":14,"lipstick_1":0,"ears_1":0,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":-1,"shoes_2":4,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":5,"bproof_1":0,"mask_1":0,"decals_1":45,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":2,"eyebrows_1":0,"face":0,"shoes_1":42,"pants_1":65}');
