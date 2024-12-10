PGDMP  /    *        
        |            stock_management_system    15.8    16.4 H    P           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            Q           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            R           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            S           1262    16440    stock_management_system    DATABASE     �   CREATE DATABASE stock_management_system WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Turkish_T�rkiye.1254';
 '   DROP DATABASE stock_management_system;
                postgres    false            �            1259    16502    admin    TABLE     �   CREATE TABLE public.admin (
    id integer NOT NULL,
    username character varying(255),
    password character varying(255)
);
    DROP TABLE public.admin;
       public         heap    postgres    false            �            1259    16501    admin_admin_id_seq    SEQUENCE     �   CREATE SEQUENCE public.admin_admin_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.admin_admin_id_seq;
       public          postgres    false    215            T           0    0    admin_admin_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.admin_admin_id_seq OWNED BY public.admin.id;
          public          postgres    false    214            �            1259    16588    branch    TABLE     �   CREATE TABLE public.branch (
    id integer NOT NULL,
    name character varying(255),
    city_id integer,
    opening_date date,
    type character(1)
);
    DROP TABLE public.branch;
       public         heap    postgres    false            �            1259    16587    branch_id_seq    SEQUENCE     �   CREATE SEQUENCE public.branch_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.branch_id_seq;
       public          postgres    false    227            U           0    0    branch_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.branch_id_seq OWNED BY public.branch.id;
          public          postgres    false    226            �            1259    16602    branch_stock    TABLE     �   CREATE TABLE public.branch_stock (
    id integer NOT NULL,
    branch_id integer,
    product_id integer,
    quantity integer
);
     DROP TABLE public.branch_stock;
       public         heap    postgres    false            �            1259    16601    branch_stock_id_seq    SEQUENCE     �   CREATE SEQUENCE public.branch_stock_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.branch_stock_id_seq;
       public          postgres    false    229            V           0    0    branch_stock_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.branch_stock_id_seq OWNED BY public.branch_stock.id;
          public          postgres    false    228            �            1259    16534    category    TABLE     |   CREATE TABLE public.category (
    id integer NOT NULL,
    name character varying(100),
    type character varying(150)
);
    DROP TABLE public.category;
       public         heap    postgres    false            �            1259    16533    category_id_seq    SEQUENCE     �   CREATE SEQUENCE public.category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.category_id_seq;
       public          postgres    false    219            W           0    0    category_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;
          public          postgres    false    218            �            1259    16574    city    TABLE     n   CREATE TABLE public.city (
    id integer NOT NULL,
    name character varying(100),
    region_id integer
);
    DROP TABLE public.city;
       public         heap    postgres    false            �            1259    16573    city_id_seq    SEQUENCE     �   CREATE SEQUENCE public.city_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.city_id_seq;
       public          postgres    false    225            X           0    0    city_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.city_id_seq OWNED BY public.city.id;
          public          postgres    false    224            �            1259    16543    product    TABLE     �   CREATE TABLE public.product (
    id integer NOT NULL,
    name character varying(200),
    cost integer,
    category_id integer
);
    DROP TABLE public.product;
       public         heap    postgres    false            �            1259    16542    product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.product_id_seq;
       public          postgres    false    221            Y           0    0    product_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;
          public          postgres    false    220            �            1259    16520    region    TABLE     �   CREATE TABLE public.region (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    admin_id integer NOT NULL
);
    DROP TABLE public.region;
       public         heap    postgres    false            �            1259    16519    region_id_seq    SEQUENCE     �   CREATE SEQUENCE public.region_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.region_id_seq;
       public          postgres    false    217            Z           0    0    region_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.region_id_seq OWNED BY public.region.id;
          public          postgres    false    216            �            1259    16557    region_stock    TABLE     �   CREATE TABLE public.region_stock (
    id integer NOT NULL,
    region_id integer,
    product_id integer,
    quantity integer
);
     DROP TABLE public.region_stock;
       public         heap    postgres    false            �            1259    16556    region_stock_id_seq    SEQUENCE     �   CREATE SEQUENCE public.region_stock_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.region_stock_id_seq;
       public          postgres    false    223            [           0    0    region_stock_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.region_stock_id_seq OWNED BY public.region_stock.id;
          public          postgres    false    222            �           2604    16505    admin id    DEFAULT     j   ALTER TABLE ONLY public.admin ALTER COLUMN id SET DEFAULT nextval('public.admin_admin_id_seq'::regclass);
 7   ALTER TABLE public.admin ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    214    215    215            �           2604    16591 	   branch id    DEFAULT     f   ALTER TABLE ONLY public.branch ALTER COLUMN id SET DEFAULT nextval('public.branch_id_seq'::regclass);
 8   ALTER TABLE public.branch ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    227    226    227            �           2604    16605    branch_stock id    DEFAULT     r   ALTER TABLE ONLY public.branch_stock ALTER COLUMN id SET DEFAULT nextval('public.branch_stock_id_seq'::regclass);
 >   ALTER TABLE public.branch_stock ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    229    228    229            �           2604    16537    category id    DEFAULT     j   ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);
 :   ALTER TABLE public.category ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    219    219            �           2604    16577    city id    DEFAULT     b   ALTER TABLE ONLY public.city ALTER COLUMN id SET DEFAULT nextval('public.city_id_seq'::regclass);
 6   ALTER TABLE public.city ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    225    225            �           2604    16546 
   product id    DEFAULT     h   ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);
 9   ALTER TABLE public.product ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    221    221            �           2604    16523 	   region id    DEFAULT     f   ALTER TABLE ONLY public.region ALTER COLUMN id SET DEFAULT nextval('public.region_id_seq'::regclass);
 8   ALTER TABLE public.region ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    217    217            �           2604    16560    region_stock id    DEFAULT     r   ALTER TABLE ONLY public.region_stock ALTER COLUMN id SET DEFAULT nextval('public.region_stock_id_seq'::regclass);
 >   ALTER TABLE public.region_stock ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    222    223    223            ?          0    16502    admin 
   TABLE DATA           7   COPY public.admin (id, username, password) FROM stdin;
    public          postgres    false    215   �N       K          0    16588    branch 
   TABLE DATA           G   COPY public.branch (id, name, city_id, opening_date, type) FROM stdin;
    public          postgres    false    227   *O       M          0    16602    branch_stock 
   TABLE DATA           K   COPY public.branch_stock (id, branch_id, product_id, quantity) FROM stdin;
    public          postgres    false    229   SX       C          0    16534    category 
   TABLE DATA           2   COPY public.category (id, name, type) FROM stdin;
    public          postgres    false    219   �"      I          0    16574    city 
   TABLE DATA           3   COPY public.city (id, name, region_id) FROM stdin;
    public          postgres    false    225   �#      E          0    16543    product 
   TABLE DATA           >   COPY public.product (id, name, cost, category_id) FROM stdin;
    public          postgres    false    221   G&      A          0    16520    region 
   TABLE DATA           4   COPY public.region (id, name, admin_id) FROM stdin;
    public          postgres    false    217   �'      G          0    16557    region_stock 
   TABLE DATA           K   COPY public.region_stock (id, region_id, product_id, quantity) FROM stdin;
    public          postgres    false    223   �'      \           0    0    admin_admin_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.admin_admin_id_seq', 7, true);
          public          postgres    false    214            ]           0    0    branch_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.branch_id_seq', 304, true);
          public          postgres    false    226            ^           0    0    branch_stock_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.branch_stock_id_seq', 8026, true);
          public          postgres    false    228            _           0    0    category_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.category_id_seq', 23, true);
          public          postgres    false    218            `           0    0    city_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.city_id_seq', 80, true);
          public          postgres    false    224            a           0    0    product_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.product_id_seq', 35, true);
          public          postgres    false    220            b           0    0    region_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.region_id_seq', 7, true);
          public          postgres    false    216            c           0    0    region_stock_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.region_stock_id_seq', 205, true);
          public          postgres    false    222            �           2606    16509    admin admin_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.admin DROP CONSTRAINT admin_pkey;
       public            postgres    false    215            �           2606    16595    branch branch_name_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.branch
    ADD CONSTRAINT branch_name_key UNIQUE (name);
 @   ALTER TABLE ONLY public.branch DROP CONSTRAINT branch_name_key;
       public            postgres    false    227            �           2606    16593    branch branch_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.branch
    ADD CONSTRAINT branch_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.branch DROP CONSTRAINT branch_pkey;
       public            postgres    false    227            �           2606    16607    branch_stock branch_stock_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.branch_stock
    ADD CONSTRAINT branch_stock_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.branch_stock DROP CONSTRAINT branch_stock_pkey;
       public            postgres    false    229            �           2606    16539    category category_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.category DROP CONSTRAINT category_pkey;
       public            postgres    false    219            �           2606    16581    city city_name_key 
   CONSTRAINT     M   ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_name_key UNIQUE (name);
 <   ALTER TABLE ONLY public.city DROP CONSTRAINT city_name_key;
       public            postgres    false    225            �           2606    16579    city city_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.city DROP CONSTRAINT city_pkey;
       public            postgres    false    225            �           2606    16550    product product_name_key 
   CONSTRAINT     S   ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_name_key UNIQUE (name);
 B   ALTER TABLE ONLY public.product DROP CONSTRAINT product_name_key;
       public            postgres    false    221            �           2606    16548    product product_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.product DROP CONSTRAINT product_pkey;
       public            postgres    false    221            �           2606    16527    region region_admin_id_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.region
    ADD CONSTRAINT region_admin_id_key UNIQUE (admin_id);
 D   ALTER TABLE ONLY public.region DROP CONSTRAINT region_admin_id_key;
       public            postgres    false    217            �           2606    16525    region region_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.region
    ADD CONSTRAINT region_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.region DROP CONSTRAINT region_pkey;
       public            postgres    false    217            �           2606    16562    region_stock region_stock_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.region_stock
    ADD CONSTRAINT region_stock_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.region_stock DROP CONSTRAINT region_stock_pkey;
       public            postgres    false    223            �           2606    16596    branch branch_city_id_fkey    FK CONSTRAINT     x   ALTER TABLE ONLY public.branch
    ADD CONSTRAINT branch_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.city(id);
 D   ALTER TABLE ONLY public.branch DROP CONSTRAINT branch_city_id_fkey;
       public          postgres    false    225    227    3233            �           2606    16608 (   branch_stock branch_stock_branch_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.branch_stock
    ADD CONSTRAINT branch_stock_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branch(id);
 R   ALTER TABLE ONLY public.branch_stock DROP CONSTRAINT branch_stock_branch_id_fkey;
       public          postgres    false    229    3237    227            �           2606    16613 )   branch_stock branch_stock_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.branch_stock
    ADD CONSTRAINT branch_stock_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(id);
 S   ALTER TABLE ONLY public.branch_stock DROP CONSTRAINT branch_stock_product_id_fkey;
       public          postgres    false    3227    221    229            �           2606    16582    city city_region_id_fkey    FK CONSTRAINT     z   ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_region_id_fkey FOREIGN KEY (region_id) REFERENCES public.region(id);
 B   ALTER TABLE ONLY public.city DROP CONSTRAINT city_region_id_fkey;
       public          postgres    false    225    217    3221            �           2606    16551     product product_category_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.category(id);
 J   ALTER TABLE ONLY public.product DROP CONSTRAINT product_category_id_fkey;
       public          postgres    false    221    3223    219            �           2606    16528    region region_admin_id_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY public.region
    ADD CONSTRAINT region_admin_id_fkey FOREIGN KEY (admin_id) REFERENCES public.admin(id);
 E   ALTER TABLE ONLY public.region DROP CONSTRAINT region_admin_id_fkey;
       public          postgres    false    3217    215    217            �           2606    16568 )   region_stock region_stock_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.region_stock
    ADD CONSTRAINT region_stock_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(id);
 S   ALTER TABLE ONLY public.region_stock DROP CONSTRAINT region_stock_product_id_fkey;
       public          postgres    false    3227    221    223            �           2606    16563 (   region_stock region_stock_region_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.region_stock
    ADD CONSTRAINT region_stock_region_id_fkey FOREIGN KEY (region_id) REFERENCES public.region(id);
 R   ALTER TABLE ONLY public.region_stock DROP CONSTRAINT region_stock_region_id_fkey;
       public          postgres    false    223    217    3221            ?   D   x�%�1
�@���1B�K��E����;��X�s�>���#�`S��D��&J-��j�S�5����      K   	  x�]�=r�9D��]j�L��LK
�V�{�s,�D5Yt&F�$"��$��?O����R׳ȳ����@-e@y������b@[F�>˴>���ʥ�[�TsP�|��x��}��7�G�g����=�`�Y,���@/��g�O)�������|��~��9����y��ϼ5;����Y�-%��,El��y�R�y�e��U���;섚{8�=<�U#|��	�R����Kbe��<sl�T��R��N+{����ϼ-����ZIj�=�ĩ�d�T~Qꙋ%�����Z�g�a{�l�:���i���<l)�|��Y��յ��s�R#��^�#2��`�V�:})�|��_j��l�W�3Q��KE�Ӗ��%��m�9����Q��W;�̥�����3j��,"�V��g>���yX'�q[����kΆk-�ʖZy�ūm=̥<A�CD���a[�X��j3�(I<�o��#����PB��ǵ���1Ó�N�����_��	�"� ɡ�.$�dˤ+�&�:����b�ȻP�(A@r(�n7�$�R�D�l��eDb}�($H��2*��r ь�z^�}ڻ`����P�h$�1[2��h�l��A�}��h�$A����H���,$�1[7�k�c��.�	�ʙB"��3�D3fkgzF�3��3;	�l��A"I�|�$Q�C?�k0c����UH@r�gUɘ��͘��%�_�ʻ~������j$�d�guM��co�/��]?k�����Z$�d�Ƕ �D[@��E��T�?M�(!�]B���E�4���j�J����q���N�CF�"ɨ�#UQHx��)�Z��$���J��!іR��H�-�
"ͨ-�Z��&�w5ժD :�Tk#���z��iFmA���E����Z'mIպ�$��TE!R�CT^�P^�OUU�D��l#��ں�P"ͨ-�
�Ɗ������X���S��G�aI��Ͻ&�&by�PXԝo���ṬUJ2���w�U��$�B����� �&��p���k�mH��W-�d�5K��Z2I`���d���İ]ūR�>�e#�&3����Re%������%�f܊��-�4�IW�k���䓶(�XQm���/�5W�t�Ic�k��6U~��,�͕��F�F�j��'�Q�٢�l�Io�k��6]~��.�͗��F�Ƌ�*����@�uxc�j�7�5aԦD :��5"ɨ�['Ҍ:��y5��2���(טQ�"��{!Ҍ:��{5��4j�No�B$uxcW"ͨ��W#�Q�i��N�D�7�A$�o�H�No�^��F�&�:
�No�H2���"ͨ��W#�Q��C�@tz�hD����щ4��cPz�Y}�{��@vz�X�$�o�%�&;�q�w�y(.o�H���$�d�7NM��o�^z��\�即'��s$��;�q�d�q�7ΨK��n���l�U�!Y�&����L��W�O��B2M&���8ˊ���h*�rG�4���%�g�d�q�Q�Փ)��7R�+�f����5[3�ґ��J&��w�;�2�&C��cQ�0�%���!_�3I&ɢ�͈|MM�d��r������֮����ŷ�]#?l�/�m���%_|��5����ŷ�]S?L�_|��5����ŷ�]s?�|�mk����o[{� �6X1���5�۱�6"!:�6�N���6T�F�d��6�I��mC]D�Q�m
�f�~� �F�c��6 DH��6@���x� %Ҍ�o�ՈVl��t"o0�$���L"ͨ�����;�p^}h��>�Wڨ��}8�>���;�p^}h��w��������u����ه��C�
���Շ���{�����o�a/W�"���iF}�^��Î�D :�P�H2��CU"ͨ�ի}���C�DHt��"!:�P'�f�ч�Ո>�z�a+D :��U"ɨ��4��>l^����K9��)����IF���iF��ͫ3V�s�$�1��-"I���B���܃�Ո�Ͽ��� ���]�$��Ѓ�D�h�<������m�A��@v�<����:c�A��4ٞy��;�<��=�Q���y0j2ɸ=�` �fܞy`���j\߃�y��^5��Aؼ�C��� l^��W��{6��Ы��=W�U���M�?��q}�zո�a���j\߃�Q��^5��AL!�ӫ�iF^5��U��f'��UsIF^5'�f��Uӫ^5�?�`"$:�jU"!:�j�H3�����ןl��D�W�F$ux��D�Q�W-�Fxո�Ѱ&�N�Z�H2j{���f��*)^��y}�I���"D�h{�%�D۫���������      M      x�L�k��w�Ƽa�2?��ܘ8�U��<I��Z~�O�~+՟9~����G�)�w��������ӿ��_����k���{�����|�����������Ϲ��{�t�-���������#�e ���o��|���ܿ��o0~���{��[?�l?㗗�%j���?}����ޮ��Ο��kn0����&����ܿ�4^����&�,���M.�o��M6�O�/�{4����G����OޣM��TJ[��(Ķ��S���砮�ǟ�z�O_�W����Ɵ��}���y\�0�ϣJ�o�����gZ%<��R%���ɼ�B��y�Q/$�RV����sKu�_��~~�@��t����[�c������]��o���4�������o�����y����0��ߗ+� ����wJ��Z~�����[��w����+�@����,)hw�=,)*7��wIA3=����¥��~'�m���~	A+��򻄠!�u%9h��o-9nk��B��[�[�̞�w_����wW�R[��!������i�c��@���wO��L��^� ��Fط,��� �:߽���g��������N�[�\A��}�#�3)� &u��)n�{��U���)
�vn��u)�s�'ʩ�+�,n�=�J��J؝�$Q|���������uY>inE�&ŵ�ܪ(�p_���~y��* ~{k�^�D[D�Q$��K4֕]�^�[&W�5�=�
�U](�z+dy��@?�X�D�@�m�J�Ӗ�T�Ar�*���k� T
ݼTI��~+
��@]�A!�[g�ʣF��U�Kr6����1��Ht���n2���-����E0�D�$�wk"]�[��T$�r�b�.�}kD�����D��ʷB��.�U��޴�;�|��}�-۫Ny����]��A�v>�n�mcW�^	�N}_�z%�$W�^�F�&�A�v��p�`���Q�C*��9Da�l�VȐ��ϠT�4j�}�;�A-�!�#e��&�6$*�*��i�C$�OZ�L�P-�5�Dh��>�r�U�e
D3��S���m�u3���V����8�J���9{#$�V�u�����v������S@C�ޢ�yH�n]4oG�m�'����v�E����>|�|��(����x�%��,[z/�a˂F�0TΪ���4T�-�+�Cߙt�-���[ T�t�#�mW���A'��U��#�ǟ�����:B9ٹ�H�ϤL�H�~:�~$��3>.ȞC����y}�X�2�������tn׮he�`��Nv��
��<�Q�����ݞ�W��z���Bf>����?G����_����[�������E4UW�(j�roT�A�}ߥ.�P;�C�V�j�R�[7�6�Z��|W��"�N�)�:�����NI%b�aL�U"f�Lb�@굎(�ѹ��J�q�"U���}�0����?��=jy�����<��qi�o�~�p\Qɓ���T�ȓ�3
�U�[;W�V4�r�VT��r��z�O��۷p��$����R�[���Ib��F]�U$�K�ԙ���8+S�� ��K�f�ݰv���I�w�X��-��;�����er^@�����|�L�>D��ΪC&����I�U�ͼx-ż�=�����&*��Po\��OD+/�Zy���îT��������ч��V^�!�Y��Jsk��]������PK6�)�d�^ч ��񧲒����.Zjt�%=�q'�Pp��RBLSh9K(�q/��r�r��L*�;��-Se�t�ErQG��"�J�wKd%�ػ������p YG���Λ�t�&݈�A5o�ͅfީ��34�V�ќP���>����F�E/ok��p07�qA�D5p$A[�M�(�=�߂8��|�$.��bj�(�v�g�dq�����IC�\}qEq2��[�����7EÔ� Jt+g�>�>�Tq�q�O(��n������Z��q-ӭ�~Wk����9W�H�����E��f 1)i�p"��g��BaC9�|�c�]w��YA�q�u��DA߆��̬��UM��J�N�niԐ�ⷢ�}�ڴUQ�>����riםd�*5�ݚmU�ԝg�c�j�5����j��$*Yh�&�e�E�@*���-E��CC����Oo"���4����Bfn������ҴuY04ܑ�ul"�=�\��5 �L�j���n^��?gn��0+9���^�n�y�~��u��>wR��M�«��� 7B¨�$���}����/eq��|+5�҆4���ű�܉ܽ�"DՔ��ۺs�6E����۔��t�Z�)f��]�L.{h S&&nL�n�VdD<\,Su��(����)��}Β	���t�r�Fp(ϫ�1��~�2ՉB�M�*��)]��5�;!�Jɥ�Bbh�S�;�G�jp𸃠j�(Ww�՞���'�������Ƶ}`��ڔ���8����@�:�m���Mym�}6�[(j�PG�ʿ���PN�a<)!ֆT��jB��Pp��S�}*���D-�ÏHT�:�i��J���D%������A/�~40�U$�}�
��gsaGB�����%r�]����z���3�s��t^��'ӈ�+�ʒK�(TѺUԋ,j���Ұ<�NE�[C���^���p_Q\A�Ў˕rv�y�Hv�N�U$G���3��s1zV���:U$j�.$�(���Z�n��{��AG�
��W��E�o/փ[]W�bݹ/�u���{|W�5�`KhK��ڵ�D�X(i@X�+'Zvܒe����΄#��r��8Y���8����]����.Us'���C��	D��Ї6���)X��aԤ�<��;�]Q"f٥]�.�5t�W)j�2х��!54y�!�38^n�Tg,��ЇH�P�)"Q/�Q���EIwgt'tt�-��t'M�v4��������B�B=k@XX���*� �a�q�π؁�R"���h��K'�4�%����V�AC,yn�l�tɃ�+<t	t����aNsǠ��a'���`���_mi����R�¸�A�la���°@�w�[j�s��P3�k�q��n�z0Q`h桕��b�x��ҽ3;������J��Ph++��Jv'���B�vpW	H�3R�Ѯ�p��)�#	���(�S��9>Y���zEi��]�V�;���'ʍ���Db�pn��PnY��?>�4!�&8>��;_e�%���[I�V�*R����L�h]�:�Huf<�H��T"�p��Q$B�р�Mt���3��HtH^�<��p�^ք0oC�eM,1ZY��\ِ�-q!L�~5|�g���}޾��g�U�h�v}{Ϲ}`4qx5^���,�\I*h_=<�<N6�V��.D���6�L�N˭͖�WD�b��V2i�+��e���w��D���T��RQI��b��Ew59�j�����=P�0YT36���hfl���@1ǆp�ʁ^Ɔp��+`�d����!��7� ���Ѝ��!��k��%��Vʐ�:�k�+�C�5Ș��:Z��)k6�<�}��@n/�@n��{Ny�]��)F���S�F�1�qs�s[q�,�c���%�s��%�|P�$bC�ꒁr�|p5Е�>ݼ�@�w�gU4P���b�����@9k> �y�텁j�|`�C3k>�ؐ�
�sIn��g�$ő�/E�us��clQ�p��,����Ǒ�M_�����R5�@�H�%8��*��� taO��9$%u$��܇�X�$r{���Vκ3����N��<��ƕ�a[|�}|q��O�BG�Q>͌��|i"i��WZH##�D-k=�#�k��3t�������`r�(�XW���J�x�$��ܡxI|�J�#��4�$%��Hr/9pUQ�\��]���n�Z+�#f��vG�+�\��mui�5��Tq�`\�U ,׷��8��Ϭ�Է5�@��,�	�+�a��6K���i<(��#1㤞�E�x���ob��xp�+,ƌ�-c�����4\��;18`<���
�g35X�AamJwY�6ܴ���}�.�k�U]X��4n�yq�5fg��^s��9bN�    ]U9�H�z:�HTӓ;wR��ܾq۲b�e�v(�!�����RQGh�9������R�3GߙB�$r��9�k�uĪg^�<t���j�����y��rPx�Uȼ������`��q���n��4�s���c?�2>Kq�Y�\�(�޹�`��7�$vzĒ��ے��ar~u�"0d����11-`f6�HZ(�-f7:�	(�i�dnѠ��D.I��-�KR��I�F_�"Q9߹�[$zwn���� �H5�/�*����H�q��^�<�pӫ��u�W��z܎��L�w��xTwMQJW��8��FB��]�:q:`����PI��|�0)Xe^Q��K���C�[�ɣ�͟
D�1�	Ě��C�2)��͕$��s��*��{�z�)���*�d��>��C�i�V����C�@��X���QZ٬\E"��8	�P���\���+뒍�mS�����/�n.6���<�bm�_f�|�z��ˑ+-$M(�p��/s�UC�����&
fk�DI�Oo�0��݄q��x7�S0��2o�Ё�yE�\�~|+���c�L�W_�&�N!w�z��v�����Qt��x�L8�]��HAWS�.�-V����ʔ��"am���i4���+$V��� 3�B�a4���>X��QU�� ��l�u�H;;�������{��Za��C�[E��)�{��S�(�Sj��aMy���<�!�TW��K��^�)Э�]֔G�;����q�o�bg�������r�䡩�.�8�^k�S�6�Zi�A,�X�6��9~4�3�<��ˁ�լ�2G3c8h��e�?٭_�e8�,�2v�>�f �v�����ck

bK��!���pMz��:��zQ�(��\�#
�!	�G:�C��H��@ZD��_G$�u�Dj���Q0'��_P$�|��'�^�W)�O&mַ��'�;?�JB�����(�7�?���&7�y�湳��j�l@{�(����#Ͽ�G1k4�wf����M9.D-k4�<�֮������ #�F'���\! �܎��$�3�,E���o����4:<(�ѬsK}�c��O�@̮�
D}~)�V�;��hfo��j
��ar�H�)��Hu���M$\����M"}��N ���k6y{pm����F3k/hoЉĦ�8���)�N�2��
�����f���C��0���
����F�^��`��5P9�������D/��]G�+��g�]�vpU��0y���!�N;�#�!Oy�=��kbj�����H,�n��C"�̯.�#�Sc��C�L��$�3�}_f����}�I��[�S���B;%ʶ�}�	�]��� vԲ��G��w6N��x��'lT
M���N����5��Q�;[����d,�;n4��b�\!ɪt/Qw�T���%�7�wI��g�%k�;H�-���TȖ����[ v�A����\+���!�t��QX[&'o떩>C��2YA������#SV>�ĎLVowdr�CFA��`ާ��1�ͻ����
�J�n�o(Bt�v�I7A5c7�*F3�u�6�A1���߅�O�J�d�8_HJ�����5:�|�����Icݢ=�8�1�8�����q�sg��c�览�����)2�0��m	Ƿ�CNI��lX�$����)�0�􁿸<�~>"�nUI�H��홧JD��~�D-\�vXn}:��lHF�aC��㐈q״s׉DyӅ�ʿ��`�ÀPp�:vV���

><�y-�x�#Z`�S�ӄ�(Ji5i�n;M�;x�7y�a��r���{��~d6�\�^5�LZ�L���q��ɝ�ʷ)!���P���t��ڦ�P.�&�J�ۭ�.�t��ebT[����nt�d��G��R��Ma��)��R�L�cD���0mK���I��V.�f�C��T������>(�ރz-��<g���؝��)K��X�<��3��w���в�
��WG�я�
tk�t�DL�f����UHg�d,?])�~�Dro�>fIt+w���wy�<��l�*P}f�����o	*�Ci�WOO�84�yeB�_-=[���\-�U����m�����1�f|�Uѳ&��
A%{��� �7�G٫��E�����s��[Q4�QRG���#̭�"w4TҎ%a�rmE"��k:�ȸZ�IאE��H�*bJG˓�Pt!6�O*7���TL���F�����%���I����i.��sB�D�����S*H���B�����[lS���G���6�c�S��
_��lq���l!�]gЮ5,��0��©R�/���W�ң�V�'� Vs�g��J��K�V�J�X�(Z�ʲ�7��d��m�O��[��"������D������Lbu/Ε��ڄs.���ׄcn�)�&\�����}�x�45��}Ń�=��F�km�E���pg��q�;���S`lû�9j��q���q�ț=���3�W��6%D��bQ}F?������4��!W�@�`.�>��L�,�$���H�!���P}C6���}�<-E�67�ͭ#+{ʖy��p�WJx�F�5C��lN?/ι�0S���b��LM=�FDXhy�P�� ��J~��g���I4_�Mb�P��C��=%oh�Qlh��6��6HEIL�bMLͷD�U��oˤ]���oK�?��mR1Y+�b9{�Um��v���d�{�n�����-�1��).��\8W���#��'�����KՕ���D5s�s�8�ţ�>��ڳ3�į��BDQO��q�T�3.vD�1L#pۘng����`����H�����1Y��C������3��Lnj0�	�~y3�P�D7l8g��EY.C(��&�p����h�-,�1o�+
���oecs�.!
��S�Š�}85_T&���Ù�	6�dP����֯k0��A�1
^��ĩ�0�*��ߓbcX�(�9��1?%�#��ˍ��!��ͳ�$q���fr!qj�0Бĩ5�l/n��ex}����c�e�f}�dJر��BWmE7����FM����B,�Ԭ�ђ#��Q��u����~/�v'�	A�S�F�ޥ�ȭ��{�D������s�8��9�'.��Ĺ���2�SkZnC8f����vގ`��K/%Dqb�X6#Կf��x��Q�1�g7�Pu(N-��_K6�B�����l��}LV$Z?���Ҩ�$���2i͵�M�\L[S�[w�F5�b/-G�⌓�Z�h���W�xŹ�t��c��h8K8�L�85{�|�h�V� K4��GY4z����lT;Ӆ���ǰԶpl�3��85~�t �8�$~q�7�k6`Ė94��zN -�[F>�pj.���6r�Ct�3j��[J?V�j[=Abfq���?[��?���6�V�8��G.g���#Xl��(jɨ;#�?�t@�Y˦�Kd��t^��bro\�'��5v7e&OLVl��E�Ld��$g|$�qjq�Cp�LH�A��8c�P�V��c���y�n\�O<PY�!σX2}�#�_,L#:��W3��%_�����/�bq$$�q}o��*��&�q%S�b6L|�}DEA���9�(��Ez������b%�¯� he4�܆��M8�Y�M8��j)���B�㊧������5��px�ׄs��˅3Tc�pᜩЈ	}\I��XC���Z�������8�/"��P��'�ס�O,���4�LkO?�;�N���j�l�83�|�}p��j��t!�qi5���_����\(�X.���b�pn�u�HTۡ��ǥᄝe���U��*SL�q�ed'KB ��6��}
�RP��\O�_�J<��S2ӵ��'r=7/��٦lTy)
��K#�A��B.�(��`�BdT��޿�f���U���� b!W�?Dd�����s�>?��� ���`9G0�2�>~{��ޤ�p���i��r�������*��-��芒���VȖ,mx���E�e����\5�IE٘�ح�h��F{��Q�	$D����G����P��n2�(�bZ�� Rr���/b%W    l+l��%W�;p�g����<'���K_��W����pI�?\<-���]tDr�(1�L��8�T���K�J2Y|[�%�%��A$Zr%M�~�xɥa�98�K����D�������ɥ]��>E.;r�5��,A.�ΦO�͙�%�a}��#e�͐�d���+�şW��xT<!�+���A�l��(�f��q�+v�UH�4���!�r�=��B �2}���KA4	��VDf*<	ͯ#G��Q��UD	�\1�lE,��nﻄ��W��\q����K��6�]�b�w�be���]�dĢ̺d���.� ̤��\1�,3�t��\��p(N«�+�$4Cc�����C:����Y���_�O;YU�lV�C�x���4��Ѵib $�riVQql�4�h-$ؒ�pJ��e.�lY F�3à���o�:��D���n�m��a������.(��e�w����R���7�MS,��K,�b�$4r��X����u��g[!�r%\Dk-��+�۾�������3 ��Rh(r�|���*M�Ҹr���˗�y��������u�x�,cb���d���2�όƏt��Db�W��A|>օHL���Ob0�$�~��t�C��|���K��MB1׌q̖tBU�[��\�WRfG,w{�"G�?�^��)S,4zB2W�I+,e��W��B\�}�6���k����pF� ��+�ϒ�5zd�2u�fE6���"B��"�a�������d�5s�]T���լ$�0�ez
��J׳ܝn�v݀�?O�B���]�� �L,�!Ls-蘃w3���(v!�e�sj�J��
��K����Qd��(���dpK��`͵ކ*wo��9�6����Esߛ�7��Zd�D��J�
6�
q�k=�E^�	g̽7�b
��+�����W|v��c�F��Z�b�J��zY���d����T�&��K�JE���4���q�<f�ob>0����J!e�wb7�v�`�C�'��x���3X��\�E��!��M$��s���%:o0��=�c��\W��ƹb[���P@e�L�	�\	BqJ8��Y-� l��j��
!�k'�.�pZ���lU7
�|
�~O_��̒��ε_��K:w��\'�ӅuD淦#c к���N"��R�����5߉�'�<W<L��Ṵ�x#?�'fx.�+�+���"<WR[X�[&���-���g21a��-������2@�	��+�&."	�\�5qg�xϥy��r�t��'�UBЕ2�X�p�����-,ۑ�]X��4$��+�s?WL+x��j}']D��	���sI-�}����$w�}nM+D��>�����!�8��>w�_"2���x�N��D}��B1</�P!�skZ�==Qc���E��N�J����ϙa�9e<r{���,D�nm+�L���j��g.�24���TS\������ӹwI0���E8����xН@[�0�\�U�����L���s���$�b�+&�#�����
ݚW�7'a�|�A����]�	�Wz��-��:�1�؛		�������U�/klBB��͔���8����2Q���Bwy�J����%��Y�.Y���t����e�R�
8d3�I4��;��!����U�>(�ۯ̿��I��0J��}e�4�`��x�!��L��L_c�|BE�3� ��2���"��I_}މ�p�+.������X-,�uTq��hэu�x���R*�_���DY�T�H�>�1K$��,����hs(K��
�K����B��/�Q,�"�A�;a/O�d���-�n_L*���y��-[����f��E3A�cXiÛ�f�E�̕l=n����61.L�|��6��Q�H�A08��H��7��H��k��®��-�j��@\	�6���3���'�G�PҭqE?�B0�N<��	'�ZWp�.��n�+v*�Iw{��z�	��JW���J�f������+��Z!g���')�p7�P\��{�X�F�/�	�qg�ӝ���8!�[��`�!�tǼ�+�M�3��
��;)54�O#y2�ѯ�6�-�@(|�M����[󊳤�&����+L�ɘF���m�$�e�Woe&������cbс�ߞ!�[��b�Pbeig��D��־�Na�;�:���F��x��,��;4���e!H��ֶ�j����������hIPw�Vo��N�>�A�[ۊ�0���E��?��M�r�l��,�.�{����,��#uk^�ǃpԭuE�+��ĝ�{��S�F�fOϓP�W��D���!5����X��Q��Pԭi�o9E��,���@�B0�m�a�`�=2�q���N�)=�X�BD�ie�)�J�ϴ´�����j�M�#㝷o?���F��A��]e�>eK�H._��/��(խ]�=0�Tw�*.�SݚU�P-����hv<c�f�����Y�� ��UZ��p8�� ���zF�kV�~Y��:��w6M	U�U����V�*���PխMe�b��t��ɺS�n��<���f:b�n]�L�(��SY4#��?��X��W_P!xuǪb.h�Ww�n�Ɋ�t���d�W.{	`�U\Q�����A �N��Y�Q,�u�%�ucSi�z"��8����Fҍ��đ$;xk"����j�Ģ�CQ�I�9���.���O�0�r	��x�B��Ӽ�Rq���Bg�&B$�I�0�B,�N(N������&f�Ms�_��,#1�{e�91a�;9��Sa�h*/��,4�����/�n�I��2����
q�4t���}D��U|�&�g<4~鴫��A��6��DI�J�O�N���L�@����;9q�A���P�(+���J��q�A��6�GJ��,+��a2Ö�U<ă�j%�2�؃�C��~�A�B��Cfl����ȆX�|А�ɦs�]�v���r�)��"�u�Wq�L0k��=$�����k�����)\�O����9�D���w�a����C&�B��֬b�j�_w�}�(Q��U����5���	�W�'ܨ~�*U�M�_�)?�o��?v=�C�_w�V�]o����'.���L<i��󃵷�Bm��L��5a���.�MO?,����縂�#v��q״P�d�$XL�$6��c[qIh��J1��Ok4�cw\WF�σ,��-=��H��������;3����*����#�$�Ġ�h&^���y%�j|���B��IZ��$���du��D�/�s�cϋ�9~��6�=�w@�����HA�����)��2F�q�'��JuՔe+۝�˞8��	O���^��I���K��C���
z��٣�e-���5Bg��*�"��sy�t�%��ұ�G�otIb�ˡJv�y|״�����Y� �ۍ�Y�����>{t^�dO��ѾB��#��I*���+��'���d#ȴ�-Lf��M(Ã�T��Y�M.ˍwh�i c�K$�I���H�&�K���e#�ͷl±˳�lى���l5��ɚ�X5�S{baqc���S^��%K�
H�d���#[{�K�����V(~/�錢�מ�X,'�����v�%"�a�R#ՄF�fՒ���"�=F�
���⢑ �cZ=�����9��)��,C���΢�'���l�QbS*��@�X�[XUe{bfi�r���A���̢�&���/2�g	���Қpۓ��Fp{���"�����2�%��$���^/��v�%�N�v�%���x�Z|�%�N�~+]r���X��`aH"�����_K$&�f-�,�]|{4�L��n�,���taѣ��ۣ��΄S7I��=��B��!����d<�ud22�{�􁰣��r��#������2��:ri��Y��^�V0���
��������0�'jHf���(�;A�\0���4D�,�(�E��L�qO�w���N����C!�=HX�8eÝw�
��ݍhܣ�
�hܣiņK8.;$�Q�=ZV�"#��̆�'��9@�G���-	E��r�W��i*J�)�%brO�6��S��{�hF    eْ0FY:}�y�*�i/��Oy�I��M8�J�ǝW��'~+:u�{zb��Z6M��D3h�sU�hz=x
z_�J��8KZSj ���J�tI���T�D�cZqo� ݣ�ʇ�� ݓ�Q�%�����iF��}A��y�@E9H,;E�c�� �2�q�!T����!�n+���qVƐ̉��{ђ-����7V��x�,�'��T�����ݥK��|�tzH3I#x���v��t�[�S:�x�L�\)�	�=�Z,�����+Ρ	�=96�7A��w|6\$J�u!���'`�^vQj<��u%_�to��C�[�kCĐ=�^&&*�E��IZY*�:�K�&S;"y��7X�=3��^-�6i$�b�䅷h�<畷hɦ�@).rx�^[2Wy��d��X��{Ⱒg��G�_
��Tܑ�0J�����/B���t���c@��0��,��J�?G�B�t*��!�<���P�9Per�J���iE�|�U�^C�"0�}�8�D)����U{O"��Ӑ
_Y/(����N� ��$/�R��!��{V��Bt���m���y:!��{���۔ؽ��+9��t��M��,&k�Mo?�w��i���*�+tN6!��$�	�M�mP>nt���sL{�!y�3�����{"�D(�^�'��T������ ο���	:��_�
'��{4�01#�Y��4�l�*�h��J(C�&�3�����Q��]0�`��&Yq��]4��li]4��g_ɦ��O�¹�y3�����SN��)�˅��
0]8����y~���*�����W*!��y�p�1�'�+�UC����2�#M,L�*!�Gϕ�<ɋ�(O�M ��^� �y���A�%q�ѽGڿ�K��z�w@�k`���Eh�y�Q�L�e�������ܕ�T�O�|XB{O�Wl:S.|��$�����$3���D���Ë,�X%|�f�����l���Z��D��t�Z8x� �s��pd��՗p-���-!�\�e��4�;�X�'��%���t��4�l_͍�6Rq*���}��N��4Xjf��]?�`�N��*z��ީ����Z��<���~'���2N��x��#�Ѐ�D����a�!��A ��<����2>-��������<jGqH�L�3�T*m��_�l���_?�?f�����wϡ+��c6?�T�����?s���P���!0�:�$����2���L����Nj��.�%h~v,����C��9"/������PWkٵ�DL��`��"��_��@;�{2�IJ6"�������dP���H{+׷W�5N��YjiaT�n���hֈ-F��l-��WW�FPq]����0ta�'y��u4�ੇ+�r{��xV��I�H�Y��g��n�}��H���u��0��*�؁X������Gg/A]l�q�h�F�h���VFM�O� ��-��H�Hw�|D ��=�1��좹������a�7y-3�k</r�e���2� [�@&q����J��J�-��e��݊��f~�ō�4bҨ#jf+Q�zE�J]_Nr"*���k��I]�gO��8F��oZ����(3x���T�zt��I!��Y�v�>;,��!�Ĉ���hnsFf���Qe���@f���z�f0�����`����r^)��βV���q���B��p��+�	(F��T���	��$�p��d7���У\��a�ʼ��`P���t=���ϙ�ܔ���OG3������k��"� :Gul��CxJ�ߣ+9A�~�s�ˁ�����B��إ&�h-��(�� ��=�E5t��Gn0��%����$wD��P��Y�\��cM���c�P�_H<)L��l�$����1=�P�+©#"��p�`�/̖����������vk��N�2`�����$eV���aKG�+��J�<�|�	�|��a6BK���1��,F% [���b{ >�-z�3�F�<<F�2sbJ��:����<a�Q�����2G��"��Ik�~�t�:BjBl�G@��PSu#�t���J]nP7u�2m��39}�R����0�]��-d�	јV��E�W��C�c����۔w6�0=)�8�%T���Q��O_>�^�9<���4O���B�@�c�B���s�W0����V8=/g�AH���I���K�z�X�W�
��-E���o�j�S�렺����F��iB�|N;$S�Ù�����X��"u�Y:�wKv�����q+;GV>ʤ��rGs��ҁFҲ�;�����3��Th21#u��<�b��ZO�2�����a����K)���]9�9�L���� &a��ک}!D)���DC���/���~ȯk9T�p��At��;ƿ��l+僙T�l�烕4b��`�?�W+��������s��`����k�'��8�c��%�ȗ�����2N��m���rQv���e�f]�ם������AZl1Y�4o<L��3�b��֦t��t]4���X�w���}hn�Y���F�P/�1�>��"t�����y#Q�"� ����� ���zsj)=��P=[<�tXm'́Fk. ��(;DP�3��t�0{N�o1�>�Ws����Kb��-4��x���k/'����E��꽍���i�ç���G�8��"�������j>�Zѽm���O��@��f�f��f �(�[�P�؜[�P�h�x�+C<�e(�wmә�t����/�Pm3���4̚��j[��X�I��P2��|y�R���iM3���tz�::A��m,�V�fdo�}��SW��������"�ئ%�t_�1�A�݌��%
7�������wc�� zЙ�|��ˢF+��jہt�U��P��9���8ǽ�`j[���3i���	'�j���
�����`�E⋜`�oCY���@�ne��P���J3�P�ebu
h��^��w���H���"��?�k-Q���q���㪷���LX�#��}^��No�G��a��5C9���t5�����B�%tfL����͚��g�Dꠗ�9�?!.�L�z	b|�� �%���@c���RuǆJ��`��j�a4����nF�n�4g���Y��T��R k"�j����p�DPkP��-I�&Z�A����~�2�R���&�Cqfۺ@��|̘�*k��YJb��=]����\���:��X=xn�b�=|9��g� �p { ��ɽ"���o����4������ly�k��p�W��]C#&c�����(�B���FM�>�"�9p�D��� bX�\L*�ʮ`�r�OZ�ɲ�?�\�ə�*L���M��	jڦ�#��X-�&MZayMvi��^~�������O��s�>[�4��W�b}��V�x"���B��j+^�˾���0�
��&�af�>"��z�� �·��
er��ĊX�M�yA> Ȇ"݁���:�a�q<a��� �O՝;��qv�G_��S�(�>OK���zwD���,4���M��ak4��LdZ�&m�U���Yq�z��$�'���ISa��ؤP������g�q��hO=�dK�^7�����{|A4b�_�5��$��d"�Ѵb���*-��!ʀ��(a4q>�����U1؏H���+BI��sF	�kW�u�@:��dU��DE�v�ߊV�_�Ǉs-=Q��rN7Q�A��{8����u��5���;�hur�~$h�x��X�Ht��M>(��ő#�O�y����-�9�{����2Z��_�ѹ�m��)��d&Eq���1B(��©�t>xňU�u+x���F'JX��̘	)�N�D�N���-�I��?�rzt�E�Ȃ�ɽ�Ḓ#���S�4	V���_;�<�ww\�1���.�0K�Ḓ<:��Gh�1���`�#x�����>|%'
��1�����y*t� .�� �����D<Q�ruO�q���������db���J��\�BIK_R�pZ�L��
�9>�W�S�D��    4=�p�Yfha�0I_l�9�hor�3^�s�?]V<&��Ë'�����$�����b�}`��ˊ=џ��0Wg����T��G� �h�=>2��G����	nq�h��O(`D��`�y'�	�����S�̂`�`&���x�h�0�����U���3��Z������J���O�H��P��ҝ4�2�Oy(��⬦L�@cOr����g?�"�Q�:���(��og69d�K
Bء��Tf:�ht"f��"��(f	��ʁs6D��:�Z�K�r4�%|vU_��0��5��?���)�3���zE 5:1������|D0I���5�Z)�Ȝ��Fc h���Q��`�0��}D���>�q&AdU�`�����(���6�� ��I��c��s: YK�t���Db�:_���0?^�%[��kh�����S���W��?������@'E�_�!=0{=��R�a����#������w�|F0���fF0�K��1���4G8MSg��pR��p߼G8[���(4�%!9�9Ù#���!��m�yX�gp.e�����<PÓ
{����K9HR���P�\�؝Ӿivj�R��<���^h�gv�0ף+I�^�
޿�]�sI�� :�e�<W��l������T���
��&���o);w@c	t��%n�_1bE�`v8ݛ��pR�[�NW>�!�	=��v0=�yE0����'�n0PL�J�P)��.U��'��x+4<������	�����Dg�ҫ�v�GT(��蔉9��K�5O�2�����JX_����/xڋ;r���9|�W?@'6�_��.��0�v����u�*���U�N��x�+D�?�*��U�V�J8M�*x	���+�^@�!�ʇ�����L�e'���zYpZ��)#��r�@��eo��(b=8.[=R��T~9g	T�ĉ�����'0�s�"��L�������#����� �� ^��=�Ԃo�ts�I0φW4�Αj��PkK��ʱ>�!��� <�!��~��{�A@�2�Vb������u���O@��g@$$�N҂0)���"�"N�E,#G�*�8�.�����,kC��˃�s�m��zö��T�9��.�#�e{���8BY���E�aC'�Vgش�0�_3t&�~/����)W�!���脎�t�:���0�#�z�%�4����K��
��j���� ��"�+�f�Bݮ��Aɬ`j��W(��ˑ�;ز�Z4�F�Z�3X�zĢ���;�x���C8�h�҂�d�FuK�1&9���C�֨y�n���\�x��i*�'�9U+'�ZjlJ'����؍y�H���%N �'/�J�'��[�`2py^!�ci�$�漿@�0%�0Ƴi�A�q�^F��^�d�[J�/��L�p�̚|;И[(78�FP�HGS7kT�2ڣܔ�2أ�R�1���w��[���I�2���Aϱ����1�>6%�>|�hk;6��}+P�c�NB��<a��g�c'h��҅�]C��T��Dɚ����n?x�X�ɮ��$��I�f �-��-]l�`f��7m�4��F�[0��U�Q���)U�v�18n�[�eN�c���Wr��������9
��vt�E��-�t��GmQ��l�������1��~�{،����ŕ�G����v� j{��bb�ıGs*.�0B���w�t�4� �N�-�L�ǟ�"�I{Q���D(�~�g8�K���/�hπ�B��(����^�8���u;�`�rK{;�h��̻et*�2#�
�:�1&�(��� �:��1&�O6��Qݧ;���I�^��@+|��0��+�n�X�+�&���WcE�;��m�;���l�;�Z6x�H�R�C�r��C�����+E�H��e[ʿ3H��@>�3��\q�):��}�I�#r��6�Ɓf�,��(] �Ì樣.r���X��2����39\�8��j#E�چ\�u�/�-4�ۨ:��3k�w�{�� �z�y�:�2*�/�ڲ�W�Q;.��@���%��h��R�w,�t��F:%�Ɇ��
�&�i��s��HGO�S���+i_�hj �)�|N��=^J��Wǆ��B����WEF2�Imx�=��������[q&5I:�iz����r��������H5$���Vަ�i�s뜡���=�,� ���I�"�m�0�i`5�@j�esz(1�Z=�Z��O�PW�Vd(�{W��-�_�Ӂ�[ӉT��t�"��`f��+��ʳ��PZ���&�=��hj�rW�{d�pj�������*s��idȌ2s��w[A�A�{D|lQ,��瑛������kMQ��?��cM����P�X{f�Cٶf��O��W��M��=B��xE0��W៕�
�VH�<�RY!�2���+F'�T�
�����Y!u��|�:��:�J��J�b�~��e7?�k�̩b�����77�l�b�8�+-+DљӄH����Ċآ��R@��g�Ӽ��QtI�˘�*�(��<2V��%�-�"�E�L+�˞��O�:�c���<gǘ>�	b�� ��{�'���o�"�/��RӾ/�Z�n�m��
�f�پ/�.��3q��$���U� �*�;�i�NqFeN��|J�^���������E��`D����\ԘhڗHUm������G4覸�P쉴ϝT-Q�v���7���m��6��qRt����u���>��vؾB���+� �et�u��at�,T�y��5����O��6��)�,�+�}5��],J��T���R̀�^Yr��c[H�)T�B���PWL�}h�y^P���Nf:�;��{05D���G�S$B��Guu+�Vo�(�L�E��F�G�2S�a����r���G|�F�>2#�m���U)����)��F�<������G�R�� �ha�A���#�آ|�H�~l�#��+��|!�7B�)`\?_��)�J�W������E ��x��hc�0֗��}3��}�HG��ʮ'y�����Wt����}�1�EUK�!FKi���c�%����ƈ<bE����%�������,Q�:�h�J�\��$��}+x���v���v���b/��b�9�������=�����ϊ�a��"�xY��@��@�W�5� ������v�5+Wːoq�r�z8���oP�`�MTg'��I+�ՁFCԱ�g����Qv���0��D�.j�8���	T6ӵ�9�C/��ϻ�NcK$�y�~o�����=:Ƶ���K�k�>gQ�8��DG����A[\Yc���RS���X��X��z5��7�(��a�>5�9T���e��(fF�3��Ő���hb�o��Ih7�g��ki׀�����S{���rb��K�!e�墦��r��M�p;G���t�Li0F9Vg�5�`���(���9*��f6��
�Y�����ܽa��z��Z�p��1��9?�xD`�͡�� ��ӕ�h�2F��b����7�Q)�H�1}�+A_�0�w��<^bR�a��@bd�2��%�ba4]o=��"�wt��5���j}t�qt���2����mc.��1n��b'�7�q�M����Zt�����r�X��������b�b%Ќ�w��L9�n�/������X�b�<^q�Qo����t��HS�)��z`X�d����W�̿��H��(���*Cc]�;�����ߞ
uotKf'��nF��xD~����ط`v�f��m��vx��������#�윎.;gO�.;[��ޱeǷ��;�l��u��M�΃�ٝ���Y�����m�'�&R���?�\ް����C��o�:@��v���ȁ�s�ٖ�����.ȡ4F��Bt����d/������_����P���{���|����-Sc�k�����t�������y4T���o1A��r��4c��6(�h����O�c���M#Ի�Q� �׎,�D�ڌ�o    �QȎ*ڠlu�������o1A���W�Ro�?x��c��y�x�3�/R���b�"[U3��i�:�e���y�Z0�P��cͶ`�G�!k�WC�[���T-���Z0�ğO&�-�[Ss6����{����v^�,2�>-Pxz7#��(6�������a����� 0������a�[�6�b)1���1���M�Fy3��(џc���x�x3�_�J�����3��k�rk@�7��<h�F�"�L�������\��5?-��3�^2�g �[+3�n$3/1��k}rRi\AxG�`FS3����b�S���C�5?Mk�s���:�	O����Vw3����×�1�]>͘�nJnW���w��
S7#�9����h��S�,�+�3�0���j� Ҥ6�!����hX��l�QU5��j�JV=��%Ջ�È�w(j������~©�Q�=�xb�`��N��Pj8V�
��8�tS}�����{�P�~sB鹦W6�����l\��Y ��1B5��Q�=�x�+�Ɔ�,%i�&�T��q)��7�����y�}en��� bYj0�#.��`����Hɷ��s5�2��y��7��{�O�Z4��?�?�ڸ��p���5k8c3���+���fT���h�^mzm�'��a*�)T��p:в�5��ח5�{4Y��B�	H���wL#½�߱?�ь��f�f�bX�
/�fT7"���1�� ��,gW"�����9�;2q��K*�f<���,)�6� Q������l�����؜j�������jXD���۫[?%U�H��"���n/��!˨����1Ĩ�O(W���w�O'r�
`�1������F����� &����M-���L�O��(����F�wO�o֛c�'R!7C�{w�7p��Qv塳����Š�aM:�x�Z�~������spC��*�h~��tr~��g�Z +����JW�Vq�j^��\���ǧby�@� lŮP&i��|�H?�;��Z�P��lɘ�?(�8����A��v(���[3y(�L�[���R�;`͈��Ҁ���2��C�9��$��]8��j34�ߵ>��,Corn��2��-iF�������P�>����t�K��k)����J�P�ۓ�C���'������-�AL�//����Bi�m~L��b ��+�+�7�fDٽczdL�W9�n�S������v�I�M�H��}D2p$r�x �z��\߶�!�}��Ay��=�C��]/(�j���� e�	�@���5<:�z��&�E��^��x�cEZO^:Y'���A�j��ۣ^��-|9��Zh�m�!Ԉ�/(Mo�������A ������������[�2��/%kY������ad������I�H}mP�����<��A uQ`�n\?�����{҇/���~��5�z��l��+:�� ��eDO�'�!���?�~�,��D:�h{r�d@_o��߇E||\�Y/�0x	���F��ß�!�9۔f�pg�bP��IËQ�}�Vlc���٘����$P�{�R$jP9�I��-�i�Z3�:.��N\�Z�ԭ
����}��w�P&�?����Y�0X����b�O ��O�zup�����ز�'cvl��G�zǖ�|2��CK�~���Ӿ��X�×Hqj��`��A4l��@jl�v MD	�@Z�<�RUls9�4,��q����G�Pք�7���~1[�aL�?��O��	c������}a#�{���r(= 1�vXlC�w��O0�����\W%o"��l2�^/	)PS���$�����z�#��9 ϜMm�Ie�bh��*|�����|��G`�h *!���3������Z��=����c#��f���yI�� �9�B���g�?o����4�����9&���Oߡ��t�E���c}���f��'���3�F�O�6��ƴ�x>��Lc�h���O��5���'BZ����K\/wǚ<A�b���?1�7�hz�l��4=9�2�ߨǟ9lfh��{��Xb�������1'f�lT���dTs3���	�f`����v#�GlO�#�5Ț��#�O�m����D�7���7�����&;�b�`�Wl�`Z��+����+�PZ�4�iu�}ܚ����M{j�t�����S,����N.��*�k��G�)�\���FC�(�*�"]_X�g�7�����
�&E+v��,/�Gٴ�a����
������|r+¨��'��%{v̑�����g�`�8���	��i��Zr��&|F��gt��w05}7?&���G�R�Y����	[��bur�g\��购
�Y���v�A�C�'7.�5�QJ�4TM@�͜C��v�q(؝8���?�;m�>!yq�p~C��X�|�x�}|<���V��1:9��?j�P���J0�Ը*桡�Y��4�D36�?������Q�& r(sҭ��((�����i����1q�A0�-����W-��âw�Gq��Ţ�?49-�VY�G�m�bb�P����O:�L�@}cP ��NşO�;�S-b��)����U�qe<�����g<��?ġ7���39Y�-t��6<���A^����Z��H���H��0T��e(c���t�H�+B���z(�c��z(��=���1<�?bs���JmR�P��B��q͘���I�dL���D�T3�hr"�@3�{���x�a�tK���B����Nk��~���JGMN�m4#�͎�)x�@��LN��o\&4xf��]��2�����sѣ>�����Lq����Mc2O�������#.ON����8���?���$Ȉ��щC����b}�ʜ\���`�gg�\�4��؈����9��C�I~���C���
��6�a18�$��=ıE'�
�F��a �9��˛�J�f ���I���G"����,�����N��A��Ĩv���1�]3�ߥoRC5��mP?�n'�X�N�3R�?F�����;;�	��{Bi<�w^)�Ʉ�h�1ށt��x�1^����t�|�x��ܝx���V'w+����D�6�$�NoU��f'����C'��4������I�?�@�'���C�'R7c��v'
5c��4w&?wt1���6�@~�lzk���yq@U~xN㑃����q��R<}@��(�1<�h��/y&��A̴���@�iƗ��t�S� ������S�Vj<�H�q�v��C�鑛�cf��aʈ��S�`D���ɭq#���'=��I��m�Ԩ���ˣ|���'�R7���J�ʰ�����Hj�f0����l�3:?��������\,)%ǘ�>�ތ�1@�\�?�'��uк�Ps�(�F͢���+C��#�:��A��?9P�?br�k4���t�x#��)��i]�x����I5�i��>3�q�3�����J#�0��?b~r7����] ~��!�c���o�� G-�?0@�u��?4@9��?0@.ڌ�:?M_�af�LW�(c
r�`��8?-;�zp%���X~cP���
����"|fo��VI��E�G/]q�P�6km1�p<r���)�H)���;���Z��c1��}D�?��#�'�����0��L�1э�;	�(�Jm��'�A�`��O�CY��O��Ln|mG}�\6�?�}���p���I_)�����P�o��,
�P�듮W��K��K���#�']����L�c@�����;����9?�� �����X�qb�@�?����������֌�IB���+Ś�7��#٠���?����!�#�w�Wo;���\�����O�zj�􏘟�wȁm�*\c���'�4C��i��jԌ�X��k��O����p��,���-eW��f!O��)��m(&����؟��>����(��'w7�⟱?iP6�_k?���1td��-B��ئ�B�    1�zm�#Ν��P���)5҃���ك��3���:F�Ϝ��q)�p��'M
���X�6��g���
a<�����'�L�E�@���2�&�nZI�b0?q�z3��,��z�X�YbSD��:�ϒ�Сq(3��u�a�����e��F�u;��]^�^x>:�(x�_B��d��a��q��8���H�P&�㟱@�c ��j�2g8�@�uV@M:¬�X�Y�c-��
���l��?�j�n1�����2f8�|�w�J�[�
����"�I·L��B0�Pb?��V)���!�0���F���Oc|�Z�H{ь��|�G1�̘�l�.��;��s���P�-��p뉯�C��:wx�f4���5�D�[�쪮��m�m@��w�VF�������i^�D)P����~�.���#�i�
����9��?��D�_�퉆p��8����� ?)�KF�_z=E�:��c2����@�_�O�� �/�'|���S�"h�K�'|�����| �/�'@������ɿIx�| ��'��Q5��yf��OL������lI�a � �^x�N^���:=e��zU���9P�j�D?"��ȍo���2El|�p$�?A&��$��	Q`/m����2����91:���J8����`� \�kC��5n\��Ĺ8�%B�Rt�H3^�T=jS���2�!�PP��1/h�b Q���ACú���n9���	���
�v�e	�p�x��O��P �'���7h�����
�~�?�f@�_�O�-�3��W�{��<��ݡ<��g��|���l�K�đI,1��N���	I>e����$�^>����b
�D�u��=65�J���O%F�+_�q	�����ֿ�����~ʄ�~�>M�f%�
*����:N����>&��ZZ�/Ƥ�>�X]�X��'<4���}���a�P��~���K����Q��v��Bԗ-��b$8pW(�k�c��[�Y�0�lQ&P�KZ��e�q|�@�_RO	�;���o+I=�7ҳ �G��݉-D�_PO�A���j��k���W�'����w�DNh��]�5&��*D�#ɗd�m��/�v9�s"�/��_�~�;�Mt"�����>1�9�{"�'v�_�E�~]w��<m���+���D��
�/��j���I0���$�"��Nq�q(~� D��K�����G���7[����'&�O�P�<���J��0�a�w~��& ��� $|8��)��D�_�t����Ͼ&�IL՝�+t�N�`QB6��M��ה�8�~��Dy`OB6-���x`�':}��K�Nt�ğ�������ý�V5��^ﰉT�tv�� ݲ�Q�����(�.�3;v��i�o�}8`O$���S�iN4���;�엞N�5�h�K�))p�� �{��D�_�L�؜��3�ƥ3 1*ᙚ��I�f*J���Q�h�+4�Ii`O��e�5Q����	;���ș��kO�I�ÜH3e�5��i�7�����O)�l���G�1%<���D}�ɱ���}"�/X&������N;l1�W����%}���[���&y
���g�03�|E����_r�1!E>�b$�t�����T?_��A��~��E:m�ؓ#<ؓPL�Ě�`�o>cB�'���hQ�S���c�$2L�H�9,!w�.&5�VB҂�8\pD�}:ƽ#�x7m^ �lӥ��׹���]�t.�ѽ����ś'+��Vizx��MqM�x*�DS��L�u/iA�hz�B�xs�SI٥ԚG�)��������K	m0=ir	�!5w��pz����~����O���
�g<4�>��o~:��r)ʒi�o��&���_�w�AD��>�q�C^��ةכ�;�'>����:2_�WI	��o."�������a��� ^0��!F��7�
F�#SA&<���d�D��$�^q�8	����81��>�d!���9"c<#��tuE�!{�aʹ�So��XŁ��5�C�✫��xt��t���>.p�.d��)��/� ���:���c���%B�8�H���.1"����%HuW\%�7�K�p�;��8�^�(���fh��0�S���kb�u�%N��l	9��&����0�[o�&�8/ �Ix������	���8�9_k�_g�hq�/�i�"�}vŘ�o�ӉP��1e=6��7S�Ld��D�Į�nN�'"}����h�[��И�褘R$[x��`��^�� �|�!����	���h̸�E��?���R�d���2��X
划�����xB��<���a<�~+��h�G����8	�G:0�8���ox����~{�]0R�氻Ć�(�7�D��(�;DST-�~c<��~C4��;:�&����[4����{!�&"}��q��D��z:Ńn"��>Sp�!'`�"j���d���~G���t+��@Y�l�(z���i`��Z��m>�h�;������67�3S�XB�mx���f\b��$1`���4M�?��&$ClM��A=�w��D��H���N������&3�D���Ho���L�����D��	�����Mc��]���P���/1�&"}����"���
�)B�cZ�#.1��)H��,D��=iQ�k��)L��e�A����[��o�&��L��ߴ��%��س\E��Fw���D����������%L��K�i��3좻�����N>M��ߔ�P&j�^�ǹ#���CK��H8Q���;�>l�R���%�L)����8� ��D�ɞ4�"c2#K�ŰH�[�i3:�(a)�������d!K��U<U��D���\���T�}K2������̉��O�KN$��ή�c�S/�4�-Nf�|�'|���r�yhA��sS��
�܄y
u6��7��K�����Rv�����4�cj
����4a�X]��o�ˤ�~C<m^w.��,�;�cXf�:�����8���~��0��>�L�'j}���> FT Y�!�oاJ���o����$Tf����F��a�[�����}�g�D��u]P�W�nF�-�8Q�%�W���)M����@3sT�3鐊<�����7i"���!�<gO�VD��14PPo()�����o�0P3�)�5��G��qѡ�)�O|ƈ�r�'���0�rZ#j}؂�����[_�h�&r��~J��^���eKZ�FVKZ���/n	~�8'���J;�y��li����)a�&���~:@�b�A.#��nي�$�췁�W�Y4�e����饘05��ZH�[N�	 l���`�	��^�o���1F�M���M��8(����9F1Tu�h���"�Q뷞Nq����[W�8BL��-����^����[o�X��b�~o���/J�+K��dpː}���%��.]���&QB��E��:;�z"�o��>�haf��oaҌ������� �~�De�|��o��|%�LT��~#������N~�tZl���I�d���dT
�"��D����(�`��Cl��Ȝ�~��Ds��j�`j6)ᅊ���t=�#@:��G1%xD���p�-��*� B6ww��PR
G�P�Y&"�oɨ��[�]����q��q&�{f���7�NQ1Nd�;\�����.�?&�����^����G#��0QT�����`#�K���^?��%;ͩ����|/<�F{rA|L�3Ң�'D���9=��};>�㿨{�>T�
��f��ۉh�I1�!��rR9~����ܻ�H���qK�nA�?��0�6�����w� �� L<��S�+}�O���C�L���A\�P�A ��8=��g���/ڬ|a_��	)��%��D��_rO�����/4��o���C�L��|�#�����1�;/��.���o�δ�>�ci� �q(&�}<J���C��d�t��#�´�)L�(�A��G�R[�jr\�dH��-E�y�ܖ0�!��K�3�w.a2��a��K���y� =�    ;iAfz~
������7��e�qj���QWO���-o\��>�.�.OY� �߸<E��X�(8	d��c��l��ߟ{�m����<%��D�ρ*w�>�#q���ˣS���qV�0���?�����{�N&���]���ja2]d8iq��� ���y��D���ݱfG��a�&mx�SF�-N�䬧��o�6-���|뉚ڢ$���!�4R16;��a�=�͠~�%����Q|b���T�a��S�����O����oE���L�۷PX������~T����m�D����S:�}��i��}٨{��[6�b]Q�o�(��������D��e�c"�߰Q�����~O�f뽅� �Qx'��ax�����e��@���8յ�K^q�G�������!�WB�1Sh�ߧg��Gz�a"����s��ߞ|GQbN�زD��'�PI�p�K����}�>���u��'�knHA��9Q�o����8���y�c.1.��ާ�.��=i�� ��RR�� ��7�xq�bƋL��o���0s>@VΨ���;@LQ�HZ���0E��U�9E�9�3d��'*#�Sl'��������
�>*�bN��h�{��7�޽���Xf����E�c^��!��ｄ���.��#"t�6�,!�j����)��#&"~&�qM�W�0� <����Eℎ��!���b7%��t��8Q�Z��~D��@Q��آ�߆}b
������L[��TgOH�����HM:=#�M*f��I2�gbg`��n����F.�}D��ݤ�����ɝ-��1Bh�w�mc���s�Xf�\N3"!{{!M�#�!j�Dŏ?A��䈒�4�#L��q��D*et��Yݢ��:C��#��:C��Eп��q8��@�_I���:CE�=Q�����C�q����CG���__��B`��-u��	q�RRM���`���I�tzA�J�-�Dȿ�޽����5�Iz��T���P�!����%���J��3�+<j��9��'DHt���2���KJ5䟑��"A3?n#���QzbY
���F.�"DT�0u��� ���2�?G��Fѿ!��:����t�o�(�[�݈mBѿ�1�S�X�w3�=��'
�=��Ɣ���r㉘CH�L�ob?��	���11�Q��P�o�(N��(��>Q�=��?>���g�����{�}�Ȧ �A�S�L���%B�G�m,!���#g�P+K��T�� �Gmn�e����Q�G����k���#/ogj6�R$��F~JR��ْ�,Q���	��r�}<<8��1ǀ��_���uMz���CL�����oO��X�/~��c]8��V�m�GE%���2��->��U!��zF��J�m�^�
-B����"˘�Ř���oA����G�χ����ǅ[�����0�E�la�4N'c��e;��������@�c����h�i7����9�Q�y���>����y򂘘F�P�10�(\����Ԥ6��[]H�|T^���@G�с��HG%n�D������F���Ņ&f!����Y!?Z�H� B<��>B�����d]�����F1. �?F�@����EA۠�?�G����?�QX���э�ɉĩy��G.�f)Hv>�)�8ghj���E�B@BE�4�6��&b�&*��g��G~�%�1�S^�)��F1]F�d�&�o�[E�D���b2���@Eႍ����d0D��3�Y�0}64�G�(v���D�k{)�!F���A����4����B���1�B�$�pC��b"�����d��"
�%����4�)H"�R�S�MZ�񰠹NAb�3�"�O��ã�1�xJ��G�z�����<�	�Q{W�iȱ��p!��ɽI� r�$3�d�A��b�C��r��D�.E���8�%#+�}�!���M&e^"T}����J�(!��w� �[���������I�"���3[�t�,���￳=&2�#�� �1�8.��4^����w��w�0�T���h(���g'(�Øp��φW?"�*��'��Rh��C-J�UNQof���C1G�+*sA��g� �As�ȗ���dx�G>��#>�z���ي��!z)y�M���$Q3i�G��l����/��Q}��:���Ȼ��ɦ��	qJB�\gt���d~�&-JfO������d@�@e.���L��~��������	��#�&����p� �E���I:s�Az�NOHD����p��"(�-j�h���O{�����@���#����O��bL�|"�Zq��?�*�O��G�)�('��#�Į0��3o�r�-�O���#�4�D���	{�3x�D�`�X���?�O��x�A�9쎢Ƹ�}:�M2cF�G�)�0�gG��Kr��f�Jا� ��gݘ���	��3&���	� ��#�����Y7xq��~P|��#�t���W�^\S��%��#���!�Y[��?�N����nP�7 �?���K���T �?�F�H)-q�Wy��I�~\���v.�ԃ�G�W�L�Q�u��[J�L�(Q�K��%'���QW�xIR�jː����<��O��M�#�3
��H�Oy�I��Q��x'�������2"�?u�frAt����>�t�/��.��hE:�y'���ݠ:�f��nqf>������[����紩�-F��IG��*��#F��eG����#H�b�����M\꼔�t��&�< l��{&yH����?�NO�/�,!�P�X�d�v�H:=��PR���"�?�NH�P�i�!���T�����u
w�z�7Z��~���!ƥ"3A����P�ǬS�9���7���Y��-�_�.r#���?�{:��+H���M �?�:���D�H��D�����\��Y���&{��x��JP����p���3���z��>��X4�1�S��B�'	���ݥG"�?[HL	���T���������}���c.�|���O��
 -¬t�`
Г�S���+N$�4�;���?��@m��w�7��w�#���)Ht�9g򏗊�������a���(���77���$��;)x"�?�w��1��k��?�N���&�B>��TƅhO	�3��NXd��xO�y��?Gy;UP۫� ��s�����^��}��Q2%��UZD�,�	w����M�������Z|��2D��=�GDU��[z�&)B��c���$s�P2��1����#���~����y%� �>e^s�>愻�Ϝ�G}��ئ���~��A�`��8A���'���ҹJ�B�x���:_�).�P��Q(���nOy�ݯJ��sD��v\�4�#D��4�#F��~�dE�υ�s���I�mؤo�F,����A�SW<"�f���>�"JĊ~�t������B���,_1^���0�f�7�z�߄fz�����ᓐ?e|��LB������(����N$xYv����V�<$.��1\�u�H��Ŗko>��1��5��<j4op���<"D)2#.�o@{�y��7�Y�D���߂d&����0��N>c!4=n~l�g��m���k�1I�̑��Lg��#�a��(`7��(9�z�dŏ�Y�����(8�p�g�_�����w��91�[9�ᘡ��P���tζ�S�z8�D�ݓ��(��7���wJ ����.E������%�%>|��C��������IK�Y�v@,A�g�D� ��!J���0S�����&��f�[��^�&j�[�e%�D�l��Ę�k��ɖ�,1z$ ��=:����Aq=�|Qc� a��� DOH���N�A���n�.�<�$����hi�b�f���Tj?l��~�ͅ.���E�,8߿�GԘ�����
l�	�ῃ(׳��I�t�-JB��Q[��.`    T�Mؘ�	q�ZLk?��S�G�2�\'<C�'N�#%}������ ?M���G�!�Є��e#�tOP��|�~���2�@�o���IaD����}1-�9��Y/�e����y1,PMTËa�T�$������>�cc�7]�+<��	��.qRS�+BB��%������'>�+LN|�%�4�xp��o<V�}j�}����:����Kt���	���0���Q������ L�Yf!��FC[�'L��f }12K?�$7Ɍ�/F&|Ӥ01�nwH�ϝ 2O����S��֋}���P����~_/�E��N	`]��螉.�4�'�g�"� ���;�����г^!��H�`�<!J���US�ȳ^.�3���&� ��ó��ey�����<�g�见��	7AM,qF���:�Qiy �2��a��8S��딩�2f��N/m�߿/���9%2�2�+�SB�-��r��⍘�wi<�!�i�������	��3����������D�X"|�G�2,H�(��b4�y�b��R{-H��ɳE�&�;�� iqB"�fZ�9%��o9��]
���-H6ة�-���D�Z��C<e#t��\�b�/}`/�����P\`S�x^���	�@�K��w���Ԅv�S�҃ �]3�0t��J|�gw�˥�n�� � ��I�X���^5�K�NT���@ ��(N��S��r։��X<sA��ZO.�����"����>-�/�S�@.�[?�D�X��Ox�B$���b$�̯�~�37�+�紬�(�̍��^A��=<A�{Z��02N���,����p�C�2�NiY��)���0/z9��|����
+i�8�T��뢟S��S��{�1y�'���a�OF�=���O��>!F�K� �A�L�����a<9AzRK�d�R/���e��o�����K�0�CM^"LƓ%!ex�(���c�2l���e*6��7E����2����00��^�������r�� ��#Sp�&]�Ů㢣ӗ��-�����i9���?�EW���%.��䨨%����!�S�p��UO�"d�B�[BL�=@"�&�_�1��������t�#P3%F&Ǳ&_�R��K���~]����W�����%D���\bT��rj1fbLnA��AP`�>꙰PO���� E= ��䈂��/�!p������z�� 9$���Ѩ�������1n<=e_hY��d����J�ņ#_�E�1�V��g�=��EH(���S G�a�>�������#L7a��%�57}��3� L���83-�wa*H-a�(N����p�#L�a���^S��6!�⩸���OQ>���>�y-�k0ox�3���97��	w<H�seR7(���ֹp��w�1���x����s�U�!@�^�\�<y�'�$�Or҂���L���'ʜ��W|�d�./�n	�'k�񉑟!�
u�y�qINA}B�#96}���$��(�K�>���A��'���:��1��˾��Ozpъ|?��n��|?�!�/ґڧ��Wp�1��'�Uӭh�����d~���9�"�'�z ؊r���(��0tl^Q�s!kW�`�z����2L�)Bv�/"\��;Ĩ�xҢ$�"5����Jt�u�0Q�K�م�;� ��W,1�u-|�XbL�~��^-a	��^Y�%H}M�]=��S������C��^�]&?���O9�yBkC?Q��d��f|b����;q`s'>� ���*��A�Iݜ�O\�.�� �k��(�F���ye�Гw�Eq���N�1�E��.c�ha�٬[G%%���ûF�W���o1��0����;�(� CIlQr$���(uL�-���K'ݢd'vr�0�N��zA]�3
b`d��bd ��2���O���g68�/P>�H�����"	1ǻZ(?�?΅�kb�#6:r^?�ݓ��|D�I�;i�����!;��!�^y>B�|� �J� �ە� �b����`^��t��d�=�0_Q��:=�����a���i��4�b��'k�L��+N̬w�"���&�y�ÚX�e؂�+�t�&Vf!�=I�=���h>5.���t����E�=_@#�b����r"j�|�c�5Gf(�83� e'��!�4�!F��3�C��ȲrA&�H� 9-��R�Y�ƒ�!H�7�R�@
�!J&ƿ������$n1^d|��)F�'*
2R,Jz
R�s
CSt��M:������p�s߉�!�+�i�Ol�S������5�18<�Ұ1�}b�;�1Wi��p���5*ΚK�1���%@�U�i�4�"b� �Y|c	25K�.A�Q�%HLm��,Q���pA��#�[�L��C�RO)�&�F2��-L�XAѢ��mN[�E��x������-NI��Р�4Y�.O�ۤр��Ƅy�Ӛ��X+OLL����10�������tX��r�Ț���c@�Y���Bc�.jn�)���Եs��s��#DOu� ɗ����Ypq���HZ��t�#N9����"����G��0�1�#L��x�0�I]�03����aF���d�g=��Hِ�K������@mr(�y�n�8�I��@Td���3��
kae�����F��O+�zac��4I�<����^x��V���
�	n�z�gtT.�@�A(����`�{= ���F����ܔ�'HO/�(�\d�k}��Y�-�Og�>qR�|�'N�,.��X���3�"��0#�_��0UQ�p�8W�4��NO����t;�������X�pP�jad���$�.�&��s���dva`$�(S��%��X�y�A�&�):�>��k��3k
�;yB����B��e$ZK��:�Z��G�$�X>z	�tڵn~FeXk�2[x`X��p�|�$����%H�>���<�h�$'�t	2�����h'��Y�G��K�8M���|��<��!�"��J���� ��7����LFA�a�Z6��a�p�X�w��	G��߫��Z-�,�)��)�"�QZz����C��d<~�C��24�ej��o���Pk�2�i�[�����-��J������Hw�����-D�yNk�UC�#���u�n��C	uh�H�^c>�+џ��jcpF����p��"���8J��J�еp�EiW|#>��P�o;����/�ޫ�\���k��E�h=d��p�Y�\"3藷2S�MZ��3��#���}��ҝ_������lw�R�^Q�iqA�*;D����t��[���ܨ�7���q���Ch^b�|��"��2�/8��P���i2�3�)�q��&FE�'��̮�.�cm6ﲆ*�1O0$�#�t�`�k���>~yL҂?B��Q���c(�4 z}.d��M����E�Oze`E�υc��;;Tw��>^��Z�N.���ĭ;+����[���ixE.�m�L'"��B�9W��\��%-Lϒ�B`��x�+�}6��&�bc>κ{b���Oz*�]��'������Ϋ8�\�v�D}Z��mC��[4�q�Asѡ����U�;J|�uY� ��GDhĤ�I	�uKsA�L�3^W�23�&Oab�)�g���I��E�-Ə�<�Z��z��-̄��[���k���,��^O>��H�E������i��|F&$<Rac&���	53�6/(<�
C���B�Ơ����0�A�"�"}Pԭ¾LGc��^}Vk�.�5���BZ�`��6_w����t�g��dx���@�xD�D��r����!OA2�e�[G��^�e�C���G������
�W?�4�^�8�6�}l�h?�4 YS�6���@eF��H(�=�T�������m�� ��!l�$T^GW��z�����7��xO�.6�e�k���c������/�+��}"��ڟa����"���#m��/�?Q�آf>q2?~�T��,~��i�|�w������S��|�'՗��C�|lU    �rH���@�&C�C��2N�a�k�2,Mx(�uCS,z�ڤ1TWcc࠘�5&�]����b���}���X%w��$�o�h���;:Cϋ�g�hGSh�}�]pl
�p���Ж�� ��,WF�^tw6վ���3��^b��� �\g��K�L�|�-��3]V/QҀ��%JƎ��]�����(�2�(1��#%P�(�(�O��	��lc`�?%��j�K���ޤ�1�Vc^��@���.������,��'�(�
���-�P��]॥��Ƒ� �����c-K+oꏚ��"tK �l!���a� !&����"�~��1#�&S]���Řs��A���d-�[��(���DG�Vm9�4<a9������8�j�2�3�-ҋ�G��Dw�{66f4��7�幚�10!���ؗP9:nm�����u�:s��C0�����U���#8x���Gx���#<���~Ȱ�Bޏ��I�گ�Ӛ�K���Tl���B�W��&36�W�,�2]��-�L�?�"Nf<��+P���+��&��{���O��^�i@Fg�O�(?2�ߌ��Agml��/��b6��A����6��������@-����ơ�q1�x:�ƶ����m,���=.�,O3|�!<6�r`�y�g��. �A�B�>�7Z7�aO1�1�f����%LB�p
�5��[���ܞbd����(�Q�S���,&�e,�~�ҳyRK�I�;�0���t�>��<A�p��b6%#3��b�ғX+��$��p�&�o�������@��@���X���<~���V2,��O�vV�c��j+�!���.!�R��2�@��m�I�������0C�f�[�Z:d3|M�oB-�-L�o��h�X��d*Hٴ8�T/'=)��nqr�R��¤��`���Ie��pb����\{�ޤ�����"�]Erc��o{v}
J��,#��C��J

Bv���>���O�� �1��N�?1JA�?A�H�=�d�R;��z�t�	W�6}�Bf�9�@÷e(<�-ǰ&���g���s�G���5;�(��f=xQ2{�$�<�̼��A�������˝s��ώe�s��r��A�������+���I:є�:f�pP9�m�$CB�o���3P�=�(���{J/>�Ŗ ��ZC*�5Dk<� ����u��جon������'|�>A��B�}�Z��AnShC��9V�qK1�RV	Q�sa�F^��saʞE�O���"2~.��ܭ���ЗD����pA�J#�f��~!?�ҷ�Dǟ4� s{�̀�:�A:���Q"�O:�:0�ʌa��@���%��?�c0�?h�;��������I��/��;,Ƌ'��,⒰�A��?׏��������hd��Ř�ְ��>Mp��Yu]��dȢD	����(�i�{J����	QfY��b��c�1��LqN�1�F�L(
3�3�L��8v01P����O���܀��<�K�'��B�'L����
�"<l�/2��x\p8'�-8�2G8[t�"�`^����:�E�w��ٽ�\�T>r���4C�?�'��o)~ƶZ���b�:"5Tn9"���=@�?�J���~�����o��L��<����ؗ��z���A������/�^��0P�z�a��_�z�!��W��T-���A��.���~j����� B6�cg!��A��E=�=�Yf�	�@�1x�� �x�W���%�W���d*�����T���8�	��!�-�ٛ'�	��O�z�$�O�pLI���g��q�ȓ@��Ro�|�'ʬ5(}cF�	��e�ΐ?y�&�q���_�|�>,LyFt� ��:LK�k���]�7*�A��uU\��2q -8�6���Ã�J�{9����I��u����qy`
��:����̾;����R
p����������&/"t6�s	{� �p���K* �Y��YK����H`6�q���UV�n�EN��"Eļ���j��PP��'cZ�=�+�7����衈0,}��I_pw^R�T�JxY���pS]�[�$����)���g��'�����Ch�E��~�����UB��B�?�jJ�ň�1�$���hAJM�-JXՑr٢d�C��Oy�&��Gp�
w^���Ն��~b���� e�þ(��������T1.8@��"�*B�B�?�����F]H���n2d ><�ˏ a)� B�N8G�L�S������d���}�S�\%�9��[�~rA��z���sB��P�'���Q����Ԧ�	O����� �>��l<�:T�*j�B՟W7C��a�c~��PQ(�"��7a\��Z/�o�%�Z�����~s�B�?��z����wXe��C
��������z�V6!�
9�P����9�8�f�"���#!�x�I�WA�zF�Q�WB^h�@f6��(uI�K�-G$���!J��/%ۓ+E9��jv�Vq��Z<!N8��kT�C*q!
U�8��HQLH	 �r��aK�?I�ƒ@������R�113$T��B�?�+�'�C��Cf�4��A�2���|��|��\�����DEZ�zz�"���%F&���%�x��dE�#�TF��u�#~i��G��h	T.7@��oi��8?����>7�H@�0���0Q���J��Q�(H�=ye����yEL��*���yH(j���_ycn��S�TCB�/�<׳���T_M-�@�m��tۤ9�jӭ�E�d��w��->$/}[�ٞ͜�#on$(����=i�[�q���n1^Ut���;���C���zA���2�u�L0U�Ԥ� �(�B�,fD�>�y� �	;�)J�EҢI��2�Z�'�y
�'����;Hgݵ��^����4 ������w���&��[��zo��6��HP�����,������i��Z��"^ʩz4��\�\��~��(ck_�*Jm-/'U�w�%&�/�	��}r�"qe�C��",�~20P!#K�
�a��t�-ws埲�X�~��|�'H�Y�j�Y��C[������E��� :5��YNn�����'�b2��"��PN៊��`X��E�Q��[��n×:��1����c&TbA��y��hS��zR"S�x�%)D[</F�k	�)D&ǔ�%�IoYb�n��B���yxB��@Q�K�,e3���<�r�ш�\%�^�<sz�; po rf滈�'C7���/�u	ҮP�O((l	��
j0`Zn(��˂h�+�P��.��sD'��-<����4�h"�����uh�-HD&Y�!�� X�B�?�V���OI�|V���x��Vr���Q�b��ds6�ܢ�c��E	���(cd)�-H(c��-J�ŀ���@QqX������.��*��
Q���љ�-�O�Ώm�~����c�)vE򉎃Y�����w��)I�A-�R �랛����eD@�?�vf5����KK�S�	�U��q�y�;�f\��n	~�Q����OL|�3L����uw�U��z
�[�=�j��Ȝ����+N����8�0-e��ck������L�R��@�?q~�®��2�LǬܳ�V҃t���XB��Zb��4ؾ�-C0o�D�M}rAx�?m^ >Ķ "�@�<1D��ZB�0~xB�(�2B��'���
A��*�
E��{z�9n)~DD+$�S�)J�B�?%��Z!럒O������ӌ=B�?a�&��0�B����3�ңՠ���A�ꟐO7�&{B]`]B>�
������(R�Xc��a�!�c�����I&�aWZO���?����H�]�cJ�)�%@T���%Ĉsc���QǓ#>�|S��8�
�~bI��["��O�.4����U]�?��)D�P�����)�4���m;Z��Aݢ��	.���2�itԀ���}*ހm	���"�{h8X��O����'ܓ�]�|�    J1��|�WE�?!��	V�ɗcT��� �Ǣ1i��=����K�ob*aA4��#�v��#H\)�pG�(��>G����8ݺ�q",�	�[��g��~hc�^�~zI(#�ifO!P�������E�?������O�h�Y��}�� U�D~���J?%�H#����Qw1(�'�O&7Ɍ��!�v���{JܢB�?��:�
-��zb����<1�"�2O_���H�R���S��Z�	�QV��rO{�?AF��(q��l9?���r�)��C�
=?�Jā��Dǭ��,�ɖl`��Q9 ?A�g�r�(�ȞE��yz��G�?a�".��@�|��_O�e��W����[�y2ͦ:qo���/b@�M�5G��ひ�ނ���Y�C<Ͱd����,t�K��1��[���_�>/��Ptd)@��wQW�|�$bTY�4�m`/aJ;��8��D]�?#z~vqt�)�ح���8��fBϿ��� q����8q$̀��=W��2��@��=^��S�-cc
��z���Sq���6}&f�,x�~��Q���<�_������B�u�@e����$�_�cʤ�Gh�����)�\t�K�'�z�Y u�"|�+`��_�>%�U!�_RO�a�C��E�iTQ�/�'�H����q��l.�Ҹm�)L���A�����-F|9��?����:3���k0O��9��i2�p��Oa`��O����N	oP��껅�$\��P�/�@������U.�����c�,Q�/i'vP�/h��yB�L�W�B$.����
��!�|� �1(��G�1]Cȿt{J�^�KǾ���B��D2��`x��>{�egœ���M;@ʿ>Z�,�����K�'�t��j.���텐�<�)B����Dt�+�SQ�Ȍ�ł���)����j��P�1������KoLz.�����/(���#��%������q:�}��A|��������� ��!������S�0>�ϼ�G������<��R���uw�1�1?���S�S��3e|Bÿ����v�m	ߴ3�#�%H��	>��p\A��B7A�"�_H��,�U��/$w#c����S��
���F!ݢ�助G��d��\4 E^Y"4 E)!�)sd�K�id<A�������Z��T��ĉ�R�t[�ʌ8�d�K��¸%�)�-��K�)!�%?K;��
!?�-��A9a���/�o��(&��Z��W`b^�9�,�Bş*���ƶ�t�� �_K�lnǲ�:e倈I;�<�,_�Âדcv��O��.$��ig���)���E¿��� �ǜ8���xJܜB����/:B$�b !��9\#�;��$'���� �����'�D�o����?���:�x�Bǿ�x�(���:�Q�:�-T��������;���/h'�f�2�xz"��DM"�_DOܺBĿ<�.���n�_�/�+�2j^T<Y �_a���ʘ�,v���ht{�xA=���vr�zEG�������x
�OxL�)�O|l����Xe�
��Rx�����wJ���_uC��#>A��=f�ʀ ����T��(�y�腌���%2����!�̚2��_�NY��_��=�"�U�P�/('v��/��X���_h�r(C!�_-9�����9�z�:��X��e��	����s��B���zs� ��y� _�r�8%�u��_}b���Rr��B��ty�k�>g�q|a!�_RNV�%YҷC&��\/n�ͅ;D�2�r)a�,�s�0�=�=�0]���K���d���3�y����S<����L���^N���/�+�t�ubw���tڃ�?҇��������/�,:(�����C���bJ� >|��-@b�e1�rm���-Dj�ִ�HX[�(��d(X�!N�|�>�b&��!N��T�h����g����-Ju�y�f��|�e����G�H��0/�zMr�L��Kb[pxJ��B����T�|U ܿIG��Xw�d��/��R�H��'ݥ�!�_�;%u����x��_PN9ʶ�����d~�cx�|���q��O����u.K�<^1��4���r����/��2�m��(��[�l�p�(մ�(Y�4�%��/D�^]����r
g�|�81���_0N9F�Zgu��$��q�$�[��Q��ä8 Q^�pb�l�pub�~�p�|��N�-���
�~��+jq\h�(���5��~��4hC|	�z�B��2�D�_0NT�abR�C��LP�S��)�)J�F�`�2��!�>2��;�)Hׯ�0)?L��L���c����M4�)L"�&���� �/ئ��4�9�A�~��R�q 0��k"�Er)t(��ŉw����nN��7iBS?-R7��{T�%�4(��^��j���ye�0lS�HD�%��~?���щY���o�L�~�� C��L"Y��,u��$� Z�(d3�@�_z:�yZ��b�,�i���t�9����ę/93�u����u�?��>�Ϲ!�%�g`�B�_��2�@�_!�X� �/=�6i�(O�E���W��G���M2�G*��Rk�>���qz���.��f��D�>�K�eT8tB�<"dBL�1krsA����T�ٮۼS�̈�'�}����8����)GF���tbs	�>ӡ����~�9�|�B�_�:E�V��KW'������=�����ǎ�6T@�������l�S��<�*�0��1nNO7���0�~���eM��/$�����~A:1wB�_�No�M���u��B�_�,7��������f����"d6��}���#xq!��$�?�Id��Ž��}��-�n��G��}6w�8ݯP�3��ʞ;D���dE�q�%rA�x:eڊv��tJ�C�_8:1��ܯ��#���^��k2w4FW'�&�RO��b�'c^�Aڸ���xS��/����	2�Q�~]ꉢ^bd��RX��]<F �~A=�. ݯx��X�T"�⤡Ѣ�@�H���)1��-��)ZH	��`��DoGY�0q~�2J��Q��%L�:R	S�.O3�1��(����} ��C���� �{�XXw+����z��bcB=}Ek�Ƅzb|G�_a� ����GUb^�x�6��/�'�c��O	\R��k�z��p���`Z����A��%���"$�G���Z��(=�W3�D_n%2_�o!&�a�bL<:*���c��#D�Ч�=��'I��,h��~qh�K��\����D�_2O|V�	OV��eħ|��2�S�-t�E�qlt��)oD��ڎ�.��"�x�:���x�~r�.�d���B��Õ-��~���|�~�_|rA�,;6��Z%]�x���
�B��ŋ'ę!9�v�;�1&��x�K�_"a2;�!LB��LA�_�O9Q���	�\@�_�f,�<gM@�/�����)�Q��%E�{Vm��/�$�*���^��-����/`��!���Gz{�I��/w���)aI�~���i(Ct��!���4O����YH��o4�d1��K�BT��,���}����B�ϩW�i"�'�|�{r�e����~]�r���G�D�r'�5�}F�?�:h�K�i�K��
��$���
	�t���ƅr�`�ȮH�돀n�`�X���/>e�C�_�O�
T��	L��Kj�	�����YbYty���`��=��gٔi�O�w0#�G4x7���>��;/�K��7@(��O���4�|W�S��<n!�L��ha&vh�8(���;�6Z�T�K¼�
��N�3ܣ�/�'K~�2�V�~�>m>��Sf
���	�+���	�)��
����~��D�Ǻ����l��>��A�_��,$�uܹ˂�~A?1�@�_�z�%�yBeҢ#�|L0��Rk+�j�d�0F��K�i�_�گc��>���ו��zx������3ҍn��<+���S6��~I?�+i��%�t|�0    ��a��ip	���7�6��:���#�@��^y��w���(�ӈ3�%9Ifֿ�}��Տ�����lT�Mħ��&�, �1�Cj��ntᏒ��M�e)�l�6����zSh��Px��`)�O�d@�)����ȶݓ� ��$D��I�C�_�rA��)�!��>�4n&�l@1�m�w1�+��$�I�Q�39�8���!FD;A4��^{q?"����O�jT��T|�ev��H.#^4�����7Xb=%zn#�o����!��SI��*�yݺ�.���GH�����Y4�%BD;|�c
�%ĬvfJl	���1d��b�f�f_bă���%�L�*�-��q�l�߫�I;)!�")���&�\��
�,I����(�8Q�%L�*w�
��2k����Ӭ�~C?55��Dz�?T��o���0�~�?=����� ����GPj��$�8�j��)�ra_|8曷 �wjf�7E��-D� +u����<"H��ylQ�\[�p���	`"5T{j����,��[�߿~~D��t�#�����8�?� N��fJ��� #��#N:.���w9�F��ᠲ�������"���7Z���~�IR�b<;If�`^�g��Q�7T��j��@�W��������h��u,���^$,u���Yf�y���O҂À�_C��e3L��o���k4���.n��h�/��������A�Z�`�n�}�d�Ĳ D#�o�E� �9�d��9�8>A��ir�TX�3�O��C�Ig��L� ���*6��~s��Ln�ܞ���;�S���\��z��"�z2��e�W̞:]N�H����¦�`'�o�2��)BN����@�dO��3��I<���﫳�f�@u=�-�9&3t�-��x8�p��$M\5
E��t�℣H�C�� ������y
Yߨ�{jfi�X�v�q��4[�y#��SB'4���z�B��ROI����f�^0��!�%�ӡ�c[$��L@��R��i��-��|#�o�'fg���@O��m����KMhA�X����ӡ��0鴙�"��eH������з�y��4j.la�5I��iq���[�'f���[�i�)�0!�[�����11�O�NX��O�n�}�|��U�>��R�KQ1��T&P�,z�2�(��<���$}�\7z����vН��m.��*+���Q��:"ԕ�נ��w�o3�A���O99�Q�w�1���l���y��8Y�<\�Vv�@q�E�O�?��G����o�8ce�K=���>��2b3�v��+N"Qgz쉤�SYS!;Yf3���#����h�y��&9��{��OE@;nY�"&�	�G��|�~xL�S|���n���߅�:�'�F�[n�S�|�'@��A�	�H|�#�4c�������"�eȰ=[v�&A�Ң���|�%�f<Y3�d�3���&C1����Bd�=��POXf���:�U��Sc

+��p���vsJe�����E&:S'��p}���A>Y���M�.�/�_���qw/���ΠY�\�1g��pOcs�Ux$-B:l-M��z��� �T�*1�?^Q��^��%;�����r�'�n)f���0���#�d���q�5U�4Pf���{���] A=�VL5{Z&�� {L�O�������
p}��ЊB>mo���^��N�̼�~���뷮O4L�˹(����^�o�~���O�"�W��!�v*r)%�� �ه<E�{`aʯ$-���G���#J�b�s�1Q��%��,�&��}G��A9��4
��������q�g'-Lq�\�j��Mj��G,5��M��x�7����n����"Y!���G�s7ޜ,fg���Vp�h���S�I4�[�)���j?���׼�#�H��#�ȗ���{�L�����j#�?�e�p��n�� #��y�$�+�@���:@1�E����H����*�F����
�(��T��"��s2<Cp}�w2h�����r�
�-���	����εQ�3e���!:�K���.���׍ٔ.�8_*�Dp	�ȅv���v�?ÊtCB1�A��%�"dl��[*;,�rKB Mrp)�7EH�q�b�E
e��0����|� ����;����anSLK����H��{���u�7#��-q�q3;Dſe�>`,q�W&�xD�P���fB�����R~���L�'D�[&
���8�%��g��d����q<�=H��{�^��7�-y#��D|�oB���H��
<�^>�"����-U�|�C��F��?�c�D�}{<����^�B�J�#.n��L�Ə$n����ߟnt�-LF�,���s���v���09�������k�[��h�g(�&Ka2&.�Tz�'۳)�6{�uc}�oX�C16;4{��wX��n4����p�H�wx(�[�O�������:"���r P#���P�h��*g�5��=��c���Sը��p���C�
�BE����ś����!���!H��:D�tlT�{X����hd��BL`�����u�7�!|:R~�����L�'I����[W������P,������؛��}��oب�I :��/T*��:��v�.���hD�{��[g���xBm�^$�[{J�����Z0Q�s�����ǈ�����*������93���^���K�Eÿ����[�(�c���KFe͊�O�G�	q�E=<qK��l�F˿�#�2�I��)P6�s��P�r~f��4j~��)1&pA�G(��"��3g������8�cd`������g��F¿CDٶ10���C��Q�^�y�	*z�F����x/.����X�3�^Jx	/!�C���2QQ�6����!��_"4�87�Q�8 K��W� �H=� J��{���tȺ���HR�ĥ���t'/���̺��q���2?�?_����>� N��032Q/O4�-�;�D��<�F��Fÿ���+����a8��#4���O4���2G����=��/�L����l6v����[�=��>B|�q�b�h�|��Vy��$c^q��@Pa����C����;�-��@ �����A�(q8�)F͏�'K��q�e�j�-G�F�O�-�'�6ɠ��JX�F˿�������2Q+�Mr��(�7TT��������72���6B��Ρv҃t�>?��lо^&'�ħJ�;����+���扎�=�'y|����(��Lg��o�x��q��v� P��#��:C%�V#���;�E7�~�{��(�	h�x�Q�#��s�r�#y�B��g�~s���8�v�Ҩ�i/�mȶv>*�	Q�6 ��l�W�ֈ���PY)�������B
G�;|Tj���G�S!���˓"��{���o�EMM�Q��
���(�7�Ԡ9LR��b�(�#^n��%H\+�%��_\b��y���߲Q�d��i��G��8i1r��� CGe>�����U����.AR��AB�2"���B}�=�=�.��3�QL��o�x��m��U�ac�r�a#�ߜ}�����#��p1��|T�;j�-U��!�3iJ-D�rOZ� ���2D� .OlQzVz>k3�����}<oi�8�c@��[�8���8�'�[�2Ί]��#j�k��F�w������~�1�3���Ԥ���(�ؚ�x��/ҿYo済��1�Bo"�?h��n4�Nj��S�(|~u�����JحF�`�ؿF�$���B� �`���)\����H���`3*��?��JL�F�n��L<Q�5yO�I����,����|tɡHI�{��7�|< L)\g䳦�
�!Q:;·���3�;DI��W��>��;����X�$��Da�7�I���)G�<�n���!�(5�?xrk�qs��M�}��.�E
r�s�xi���ύ;��ѽ��7r��*�^I�.�-3���T��?���A��A<���~�C��j  
  z0���K��#�(=� �<o~�it����G�F�O�?��i��G�(���G"jQ-S�L�H3�a�1Vi��!�z$8Tx�����,_@<��PM^0��I��*����3TS��!��Zk��s=��C�	��=���z�%6�
.��19� S���D�������A��*��F��"^j�G�?�d��I23�;�s���F����>��)()���Ū���kx�F�.Ň�0U��8��v�%ub��)(>.5�"C��pP�����pPks7�W��Ob}E���o��W(�Q�@�Y0��B�ۡ�?�B�)����B��L���7�/���F��9�IS=BD�A�A�I�)'��3��8m�S�"q�����]���b����C�U�7�~���!k������ UϞ\dԳ>.F��.�Q�b�g&�a�A���	��?��Q����@@1d��?�|�拨��	`{j$���$�.m�Gq2���E��ޭN/��T�ge1�<s[�"T�W��'�V�G���Ll$�G�(��;���'}b���� 㜚�F��u&�O����#�?Pl��w�M�\���[VH����P�r��i&i1r�<%7D�O�e��e�+H���P,(��������	��e�YF���.�Yq�Ǹ,�+0�e�M�� i��F�<�Χ�s��Q���.�X�̩���'\���'�;��Ǩ�	�����SNnk��G?�C#X�Kg}h�K��+}D�F2HZ���A����ˏݽ|�$��/Yb���dXb�-�9F��TFD�G7���C���*.��㑠$��ʄY��|�
Q�!����a\`��dl�<6���(f,K��`�S�ik��7(�����S"�4Z�#��L�1��^�jR��L+آc��i�5�c��?O�[��r��-��V9���S�[��$O��[~1�T�"�d�A�l�ǀ#�'��S~�X��6��#����(e����9ѱ��v������֡�?v�b��	/��G���RH���P�H'X���]�������t�J���I'� �����A��`0�A�T+izZp �BL�f�������@'���(��^v�(�4��(qk�{1-��Q��� �����?��<���5W���>���Ɩb�E��sb������LF���r\o�J֮�� �?���?����mϽLweW =�	㔦���x�_�I	���6R���.8J����/n���O�E�t���G��8�����7%%8Ϧ�oѱ��Ut��p㛶5E���C��z(�)H�d��C�`�2�"�?�M�����&� �����4�)JV84�)���Q���Uo����w�%��oJ��F������s�r���wg1}�y����M�u�S:q�@@F֕9����'�����tS��7���x�uS�`�3L�o2U����7��P���?j���&��
�;����fs[G����O���$F���]�4Bղ���{34?F�����0z��W�����3���3�R��I6Y���M6.����?��T��I6U�4�I6�����03�f�=�
(���h��>A��&���%%�S�D`%��5��c�r��G�[����p�I!�\�t�"~l/_�$VY�����ᗥv	~G�(�h�u���!�S�d���v}��Gį�7C�"���x;����PCǯ����~w��(�u��r���(�D5���2$�tD͈�������b �a�����:��#�.$0C�O��w]-��o;ـ��S��_eƉ�}%?6[|?���%y'��J�,Q?�������V}�4����xǖqt��$��_z{�#�i�B9���$�0���%�6�N��})N!��28�`ri�h�u�;7��k۫��L3yz��f ]�!l������k��)K�q-5��@���S���-2�2���1��7Z~l�l��S۵l��T���#ゔ��~%?��W�DƏ�4��Ξ!�o{���*~���Důû�Sp��W��}�G��*
f��u0�%0"��1�"m����#Y�;���xa�25&����>�tp"��1���Dѯ�LO���?�=e����_ǝ�n$��Oz6O$�:�.�Eҟ��$<��kSH�O�^��9�[����A?���}���D[�#ΫH�2��v9��t�YCBR6�)���;]^9��+y'��u�4Q��ऴ��1�b��+��F�`��� X�d�?�
av����^�����D(SH�UX�t����}
ǖ�u��P+t�'��;{x�v(i`�y�Pz��#�޴>�;�n@�l͕�H�L*��P��0�vw�;�Ze��,j;1����U��N��2�\?������~<��͕-���m��6����rU��>A�!G �����v��G�HP�t'CG�2����#�
?�졅��Q4�`j[�>�#��U#���E2�j��_�_:Bik��HK��HP��R	�j����#Bi�������|� ��o�      C     x�m��n�0���S�	����1��V�J��b "4F!T��/�jB�7��~�-9g�Xn���#�jy2l5�g"��s�:c�j��/��A_؉���l��~�r�e���n��J߃Z=B���h+��JPj2	Z�+9֠����ʐ�'v��A�EҲ7d���{Cl�!���@nxܹ}n߰r�\���ܞ���/��3���Hg�N�:,dF���]�jᾇ�4R��#���RGU�!�g��-�� �����      I   �  x�ES�n�0<�>��[��F�40� MZ E/k��	QT@I��_T�P_z���u�	��̒��}0�۶c��EALO�Ү�yK���*��6��U��2<��O�\Ul�8�5��X�V;ЂֽkhA�l���%=r�n��iv��E��F�t%$���XC&��j�B�)��r>Z����d|<�+e�%���^&�.h�24y	�������~��qH+LIG�cc�n+}��&����*���t���2���T*��o��{�@�{T��p8�`�!Kzn�Wп���D���
�@o��R$	:X���)}ѣ���ƾ��Dݠ9=��TЍv��>��ܢB�%=5R�A�c��Z���͛��t�t$�ucD1M��|w�6��X;�$k��kT7�_D��>�.Ӟ�����;h/�����8�Bzheʃ�,�"Z��+�1�.<I0����I*�U�N0VA���9}��,�g��5\^&�-��B�)�%��w y(���"ln�ھ��!�	���8�����p3 ]�Q�ݻRNO���^�r�KwA���Y�|�d+��ZDp��q���N�è
^k��s���vv���@�,�&�
l�){���P����tãf۩7�Z��]���_uL6      E   >  x�-��n�0E��_�H川- �UAB
R7ݸ��(i�HX��;v��9���Z�p����s�dΒp�U:��|5�Z�2���!R�h	=��a㡵)�q���^�+Ilea��~�Y��-"��,3k�d��.V��9��\�x�m"l��5uiK���	�6�C&�$<�0.P�n`��G\���Fa���C�K��9&)𖖪�.���xM�{\2{&=��f�т�)�4h�48��u�-�)�!���0�	�8RMK2���=�:/�P�4�% ����y����F�FIv��O����%֤_/��K�h�      A   Z   x�3��M,�M,J�4�2�tMO�4�2��LVp�KL��)�4�2��ʧ��eVq�p�r:fCئ\f�.��p�f\��y��)Ȣ�\1z\\\ ��      G   )  x�=�Y�� ���I�I�^��u�[ةT��� !�Z*����[9D���=�� �����DAe-�U&7�.���<�>����*
�a,Ϫb�hBT�x�ȣ�Qb�9#,�f����Q��])AϷMQ��� �@D��A�J?���+a�Ei�p	�$\K8�h��!�qH0e�����.�'����L`��XL�U)E�Eπ_�e�A�����1tM��ch���Y�e�5�L��j�ej��Hә!8��d�tPU2R;3�i�������ڥ�j��`�T�� �J��&��v�i�z[�����[V��)Y5�8���jUX�]�a�o��w�L��%#�.�#,vH��
��K>�(O�G"�+d	I�'e��$�{�i�]#(Y7SKT�����5�p\�jnw��Vp����IB7�z�R�I�-6�bk.��ؘ�=[l̕�s���x$`��^��K�A-ڼ��=dZG���F*;y���^��?N��R2lW�%�c��ʖR��Oc�ų7�a����s�mȚΑ����T�����#6�F���{�0x�@
6������U8�{l^Zl!�*�E�� �����#��S^�}��c2 ����s��q�VS%��b�ﭨ��ci7��M
����{W���ht�X���*4j��T5�l�bۑSVݖ�����U�%��Ƞޜ�.��er@��E����ۻGh�l9�q�)��z�Cʒ��v��@Y�9d��m�������t��,���[ެ�[���<F&o��@�nN;ʾB�w༱	��ܙ�ȕ��~�Sl<�9<[(!��	!�_��@|�	��"K'B�h/s�,z�=���^c"�����tk6��I|��sf��sϒ����d��1+}e/�ҩ�eu~�/}�����g;-�;9{#>�{o7O�=����X��ޗ嶕�W{�{�.Jމ]�5�b�{�x��%mۢ[�3�������@�[G����92��ˑ�g�9X�v�`{��R��n呃�7g������/�������Gd���.�����yF�������0��������x     