
--
-- Name: faucet_claims; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.faucet_claims (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    wallet_address text NOT NULL,
    ip_address text NOT NULL,
    amount numeric NOT NULL,
    tx_hash text NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE public.faucet_claims OWNER TO postgres;

--
-- Name: interview_collection_tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.interview_collection_tags (
    collection_id uuid NOT NULL,
    tag_id uuid NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE public.interview_collection_tags OWNER TO postgres;

--
-- Name: interview_collections; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.interview_collections (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    title text NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    icon text DEFAULT 'https://www.mianshiya.com/bank/1860871861809897474'::text,
    sort integer DEFAULT 0
);


ALTER TABLE public.interview_collections OWNER TO postgres;

--
-- Name: COLUMN interview_collections.icon; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.interview_collections.icon IS '图标';


--
-- Name: COLUMN interview_collections.sort; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.interview_collections.sort IS 'Sort order for display';


--
-- Name: interview_question; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.interview_question (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    title text NOT NULL,
    content text,
    collection_id uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    difficulty text DEFAULT '简单'::text,
    is_vip boolean DEFAULT false,
    sort integer DEFAULT 0,
    vip_level_required integer DEFAULT 0,
    CONSTRAINT interview_question_difficulty_check CHECK ((difficulty = ANY (ARRAY['简单'::text, '中等'::text, '困难'::text])))
);


ALTER TABLE public.interview_question OWNER TO postgres;

--
-- Name: COLUMN interview_question.difficulty; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.interview_question.difficulty IS 'Difficulty level: 简单, 中等, 困难';


--
-- Name: COLUMN interview_question.is_vip; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.interview_question.is_vip IS 'Whether the question is for VIP users only';


--
-- Name: COLUMN interview_question.sort; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.interview_question.sort IS 'Sort order for display';


--
-- Name: COLUMN interview_question.vip_level_required; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.interview_question.vip_level_required IS '查看该题目需要的最低VIP等级';


--
-- Name: interview_question_tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.interview_question_tags (
    question_id uuid NOT NULL,
    tag_id uuid NOT NULL
);


ALTER TABLE public.interview_question_tags OWNER TO postgres;

--
-- Name: interview_tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.interview_tags (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    slug text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    sort integer DEFAULT 0
);


ALTER TABLE public.interview_tags OWNER TO postgres;

--
-- Name: COLUMN interview_tags.sort; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.interview_tags.sort IS 'Sort order for display';


--
-- Name: menu_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.menu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.menu_id_seq OWNER TO postgres;

--
-- Name: post_cate_relations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post_cate_relations (
    post_id uuid NOT NULL,
    cate_id uuid NOT NULL
);


ALTER TABLE public.post_cate_relations OWNER TO postgres;

--
-- Name: post_cates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post_cates (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    slug text NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.post_cates OWNER TO postgres;

--
-- Name: post_comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post_comments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    post_id uuid NOT NULL,
    user_id uuid NOT NULL,
    parent_id uuid,
    content text NOT NULL,
    is_deleted boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.post_comments OWNER TO postgres;

--
-- Name: posts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.posts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    title text NOT NULL,
    slug text NOT NULL,
    content text NOT NULL,
    excerpt text,
    author_id uuid NOT NULL,
    published boolean DEFAULT false,
    is_public boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.posts OWNER TO postgres;

--
-- Name: qa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qa (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    is_public boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.qa OWNER TO postgres;

--
-- Name: qa_discussions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qa_discussions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    qa_id uuid NOT NULL,
    user_id uuid NOT NULL,
    content text NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.qa_discussions OWNER TO postgres;

--
-- Name: user_profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_profiles (
    id uuid NOT NULL,
    username text NOT NULL,
    display_name text,
    avatar_url text,
    bio text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    vip_level integer DEFAULT 0,
    is_admin boolean,
    phone text
);


ALTER TABLE public.user_profiles OWNER TO postgres;

--
-- Name: COLUMN user_profiles.vip_level; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.user_profiles.vip_level IS '用户VIP等级，0为普通用户';


--
-- Name: verification_codes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.verification_codes (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    phone text NOT NULL,
    code text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    expires_at timestamp with time zone NOT NULL
);


ALTER TABLE public.verification_codes OWNER TO postgres;

--
-- Name: faucet_claims faucet_claims_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faucet_claims
    ADD CONSTRAINT faucet_claims_pkey PRIMARY KEY (id);


--
-- Name: faucet_claims faucet_claims_wallet_address_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faucet_claims
    ADD CONSTRAINT faucet_claims_wallet_address_unique UNIQUE (wallet_address);


--
-- Name: interview_collection_tags interview_collection_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interview_collection_tags
    ADD CONSTRAINT interview_collection_tags_pkey PRIMARY KEY (id);


--
-- Name: interview_collections interview_collections_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interview_collections
    ADD CONSTRAINT interview_collections_pkey PRIMARY KEY (id);


--
-- Name: interview_question interview_question_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interview_question
    ADD CONSTRAINT interview_question_pkey PRIMARY KEY (id);


--
-- Name: interview_question_tags interview_question_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interview_question_tags
    ADD CONSTRAINT interview_question_tags_pkey PRIMARY KEY (question_id, tag_id);


--
-- Name: interview_tags interview_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interview_tags
    ADD CONSTRAINT interview_tags_pkey PRIMARY KEY (id);


--
-- Name: interview_tags interview_tags_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interview_tags
    ADD CONSTRAINT interview_tags_slug_key UNIQUE (slug);


--
-- Name: post_cate_relations post_cate_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_cate_relations
    ADD CONSTRAINT post_cate_relations_pkey PRIMARY KEY (post_id, cate_id);


--
-- Name: post_cates post_cates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_cates
    ADD CONSTRAINT post_cates_pkey PRIMARY KEY (id);


--
-- Name: post_comments post_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_comments
    ADD CONSTRAINT post_comments_pkey PRIMARY KEY (id);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: qa_discussions qa_discussions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qa_discussions
    ADD CONSTRAINT qa_discussions_pkey PRIMARY KEY (id);


--
-- Name: qa qa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qa
    ADD CONSTRAINT qa_pkey PRIMARY KEY (id);


--
-- Name: user_profiles user_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_pkey PRIMARY KEY (id);


--
-- Name: verification_codes verification_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.verification_codes
    ADD CONSTRAINT verification_codes_pkey PRIMARY KEY (id);


--
-- Name: idx_faucet_claims_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_faucet_claims_created_at ON public.faucet_claims USING btree (created_at);


--
-- Name: idx_faucet_claims_ip_address; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_faucet_claims_ip_address ON public.faucet_claims USING btree (ip_address);


--
-- Name: idx_faucet_claims_wallet_address; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_faucet_claims_wallet_address ON public.faucet_claims USING btree (wallet_address);


--
-- Name: idx_post_cates_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_post_cates_name ON public.post_cates USING btree (name);


--
-- Name: idx_post_cates_slug; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_post_cates_slug ON public.post_cates USING btree (slug);


--
-- Name: idx_post_comments_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_post_comments_parent_id ON public.post_comments USING btree (parent_id);


--
-- Name: idx_post_comments_post_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_post_comments_post_id ON public.post_comments USING btree (post_id);


--
-- Name: idx_post_comments_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_post_comments_user_id ON public.post_comments USING btree (user_id);


--
-- Name: idx_posts_author_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_posts_author_id ON public.posts USING btree (author_id);


--
-- Name: idx_posts_slug; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_posts_slug ON public.posts USING btree (slug);


--
-- Name: idx_user_profiles_username; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_user_profiles_username ON public.user_profiles USING btree (username);


--
-- Name: idx_verification_codes_phone_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_verification_codes_phone_code ON public.verification_codes USING btree (phone, code);


--
-- Name: post_cate_relations fk_post_cate_relations_post; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_cate_relations
    ADD CONSTRAINT fk_post_cate_relations_post FOREIGN KEY (post_id) REFERENCES public.posts(id);


--
-- Name: post_cate_relations fk_post_cate_relations_post_cate; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_cate_relations
    ADD CONSTRAINT fk_post_cate_relations_post_cate FOREIGN KEY (cate_id) REFERENCES public.post_cates(id);


--
-- Name: post_comments fk_post_comments_replies; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_comments
    ADD CONSTRAINT fk_post_comments_replies FOREIGN KEY (parent_id) REFERENCES public.post_comments(id);


--
-- Name: post_comments fk_post_comments_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_comments
    ADD CONSTRAINT fk_post_comments_user FOREIGN KEY (user_id) REFERENCES public.user_profiles(id);


--
-- Name: post_comments fk_posts_comments; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_comments
    ADD CONSTRAINT fk_posts_comments FOREIGN KEY (post_id) REFERENCES public.posts(id);


--
-- Name: posts fk_user_profiles_posts; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT fk_user_profiles_posts FOREIGN KEY (author_id) REFERENCES public.user_profiles(id);


--
-- Name: interview_collection_tags interview_collection_tags_collection_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interview_collection_tags
    ADD CONSTRAINT interview_collection_tags_collection_id_fkey FOREIGN KEY (collection_id) REFERENCES public.interview_collections(id) ON DELETE CASCADE;


--
-- Name: interview_collection_tags interview_collection_tags_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interview_collection_tags
    ADD CONSTRAINT interview_collection_tags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.interview_tags(id) ON DELETE CASCADE;


--
-- Name: interview_question interview_question_collection_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interview_question
    ADD CONSTRAINT interview_question_collection_id_fkey FOREIGN KEY (collection_id) REFERENCES public.interview_collections(id) ON DELETE SET NULL;


--
-- Name: interview_question_tags interview_question_tags_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interview_question_tags
    ADD CONSTRAINT interview_question_tags_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.interview_question(id) ON DELETE CASCADE;


--
-- Name: interview_question_tags interview_question_tags_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interview_question_tags
    ADD CONSTRAINT interview_question_tags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.interview_tags(id) ON DELETE CASCADE;


--
-- Name: qa_discussions qa_discussions_qa_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qa_discussions
    ADD CONSTRAINT qa_discussions_qa_id_fkey FOREIGN KEY (qa_id) REFERENCES public.qa(id) ON DELETE CASCADE;


--
-- Name: qa_discussions qa_discussions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qa_discussions
    ADD CONSTRAINT qa_discussions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.user_profiles(id) ON DELETE CASCADE;


--
-- Name: qa qa_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qa
    ADD CONSTRAINT qa_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.user_profiles(id) ON DELETE CASCADE;


--
-- Name: qa_discussions Admins can delete discussions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can delete discussions" ON public.qa_discussions FOR DELETE USING ((EXISTS ( SELECT 1
   FROM public.user_profiles
  WHERE ((user_profiles.id = auth.uid()) AND (user_profiles.is_admin = true)))));


--
-- Name: qa Admins can update all QAs; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can update all QAs" ON public.qa FOR UPDATE USING ((EXISTS ( SELECT 1
   FROM public.user_profiles
  WHERE ((user_profiles.id = auth.uid()) AND (user_profiles.is_admin = true)))));


--
-- Name: qa Admins can view all QAs; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can view all QAs" ON public.qa FOR SELECT USING ((EXISTS ( SELECT 1
   FROM public.user_profiles
  WHERE ((user_profiles.id = auth.uid()) AND (user_profiles.is_admin = true)))));


--
-- Name: qa Anyone can view public QAs; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Anyone can view public QAs" ON public.qa FOR SELECT USING ((is_public = true));


--
-- Name: qa Authenticated users can create QAs; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Authenticated users can create QAs" ON public.qa FOR INSERT WITH CHECK ((auth.uid() = user_id));


--
-- Name: qa_discussions Authenticated users can discuss; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Authenticated users can discuss" ON public.qa_discussions FOR INSERT WITH CHECK ((auth.uid() = user_id));


--
-- Name: interview_collection_tags Enable delete for authenticated users only; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable delete for authenticated users only" ON public.interview_collection_tags FOR DELETE TO authenticated USING (true);


--
-- Name: interview_collections Enable delete for authenticated users only; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable delete for authenticated users only" ON public.interview_collections FOR DELETE TO authenticated USING (true);


--
-- Name: interview_question Enable delete for authenticated users only; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable delete for authenticated users only" ON public.interview_question FOR DELETE TO authenticated USING (true);


--
-- Name: interview_question_tags Enable delete for authenticated users only; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable delete for authenticated users only" ON public.interview_question_tags FOR DELETE TO authenticated USING (true);


--
-- Name: interview_tags Enable delete for authenticated users only; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable delete for authenticated users only" ON public.interview_tags FOR DELETE TO authenticated USING (true);


--
-- Name: interview_collection_tags Enable insert for authenticated users only; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable insert for authenticated users only" ON public.interview_collection_tags FOR INSERT TO authenticated WITH CHECK (true);


--
-- Name: interview_collections Enable insert for authenticated users only; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable insert for authenticated users only" ON public.interview_collections FOR INSERT TO authenticated WITH CHECK (true);


--
-- Name: interview_question Enable insert for authenticated users only; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable insert for authenticated users only" ON public.interview_question FOR INSERT TO authenticated WITH CHECK (true);


--
-- Name: interview_question_tags Enable insert for authenticated users only; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable insert for authenticated users only" ON public.interview_question_tags FOR INSERT TO authenticated WITH CHECK (true);


--
-- Name: interview_tags Enable insert for authenticated users only; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable insert for authenticated users only" ON public.interview_tags FOR INSERT TO authenticated WITH CHECK (true);


--
-- Name: user_profiles Enable insert for authenticated users only; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable insert for authenticated users only" ON public.user_profiles FOR INSERT TO authenticated WITH CHECK (true);


--
-- Name: interview_collection_tags Enable read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all users" ON public.interview_collection_tags FOR SELECT USING (true);


--
-- Name: interview_collections Enable read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all users" ON public.interview_collections FOR SELECT USING (true);


--
-- Name: interview_question Enable read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all users" ON public.interview_question FOR SELECT USING (true);


--
-- Name: interview_question_tags Enable read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all users" ON public.interview_question_tags FOR SELECT USING (true);


--
-- Name: interview_tags Enable read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all users" ON public.interview_tags FOR SELECT USING (true);


--
-- Name: posts Enable read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all users" ON public.posts FOR SELECT USING (true);


--
-- Name: user_profiles Enable read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all users" ON public.user_profiles FOR SELECT USING (true);


--
-- Name: interview_collections Enable update for authenticated users only; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable update for authenticated users only" ON public.interview_collections FOR UPDATE TO authenticated USING (true);


--
-- Name: interview_question Enable update for authenticated users only; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable update for authenticated users only" ON public.interview_question FOR UPDATE TO authenticated USING (true);


--
-- Name: interview_tags Enable update for authenticated users only; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable update for authenticated users only" ON public.interview_tags FOR UPDATE TO authenticated USING (true);


--
-- Name: user_profiles Policy with table joins; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Policy with table joins" ON public.user_profiles FOR UPDATE USING ((auth.uid() = id));


--
-- Name: qa Users can update own QAs; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update own QAs" ON public.qa FOR UPDATE USING ((auth.uid() = user_id));


--
-- Name: qa Users can view own QAs; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view own QAs" ON public.qa FOR SELECT USING ((auth.uid() = user_id));


--
-- Name: qa_discussions View discussions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "View discussions" ON public.qa_discussions FOR SELECT USING (((EXISTS ( SELECT 1
   FROM public.qa
  WHERE ((qa.id = qa_discussions.qa_id) AND ((qa.is_public = true) OR (qa.user_id = auth.uid()))))) OR (EXISTS ( SELECT 1
   FROM public.user_profiles
  WHERE ((user_profiles.id = auth.uid()) AND (user_profiles.is_admin = true))))));


